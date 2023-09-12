part of 'task_bloc.dart';

abstract class TaskState {}

abstract class TaskActionState extends TaskState {}

final class TaskInitialState extends TaskState {}

final class TaskLoadingState extends TaskState {}

final class TaskFetchSuccessfullState extends TaskState {
  List<Task> taskList;
  TaskFetchSuccessfullState({required this.taskList});
}

final class TaskEditedState extends TaskActionState {}

final class TaskDeletedState extends TaskActionState {}

final class ActionFailedState extends TaskActionState {}
