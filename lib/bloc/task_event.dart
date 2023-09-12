part of 'task_bloc.dart';

abstract class TaskEvent {}

abstract class TaskActionEvent extends TaskEvent {}

class InitTaskEvent extends TaskEvent {}

class PatchTaskEvent extends TaskEvent {
  Map<String, dynamic> body;
  int id;
  PatchTaskEvent({required this.body, required this.id});
}

class UpdateTaskEvent extends TaskEvent {
  Map<String, dynamic> body;
  int id;
  UpdateTaskEvent({required this.body, required this.id});
}

class DeleteTaskEvent extends TaskActionEvent {
  int id;
  DeleteTaskEvent({required this.id});
}
