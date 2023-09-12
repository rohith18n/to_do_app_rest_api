import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_rest_api/data/api.dart';
import 'package:to_do_app_rest_api/data/task_model.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitialState()) {
    on<InitTaskEvent>(initTaskEvent);
    on<DeleteTaskEvent>(deleteTaskEvent);
    on<PatchTaskEvent>(patchTaskEvent);
    on<UpdateTaskEvent>(updateTaskEvent);
  }

  FutureOr<void> initTaskEvent(
      InitTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    final taskList = await Api.getTasks();
    emit(TaskFetchSuccessfullState(taskList: taskList));
  }

  FutureOr<void> deleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final isDeleted = await Api.deleteTask(event.id);
      if (isDeleted) {
        emit(TaskDeletedState());
      } else {
        emit(ActionFailedState());
      }
    } catch (e) {
      emit(ActionFailedState());
    }
  }

  FutureOr<void> patchTaskEvent(
      PatchTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final issucceeded = await Api.patchTask(event.body, event.id);
      if (issucceeded) {
        emit(TaskEditedState());
      } else {
        emit(ActionFailedState());
      }
    } catch (e) {
      emit(ActionFailedState());
    }
  }

  FutureOr<void> updateTaskEvent(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final issucceeded = await Api.updateTask(event.body, event.id);
      if (issucceeded) {
        emit(TaskEditedState());
      } else {
        emit(ActionFailedState());
      }
    } catch (e) {
      emit(ActionFailedState());
    }
  }
}
