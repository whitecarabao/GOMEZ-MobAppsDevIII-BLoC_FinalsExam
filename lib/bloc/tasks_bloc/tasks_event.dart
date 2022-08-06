part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
}

class AddTask extends TasksEvent {
  final Task task;
  const AddTask(this.task);
  @override
  List<Object?> get props => [task];
}

class EditTask extends TasksEvent {
  final Task task;
  const EditTask(this.task);
  @override
  List<Object?> get props => [task];
}

class RecycleTask extends TasksEvent {
  final Task task;
  const RecycleTask(this.task);
  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TasksEvent {
  final Task task;
  const DeleteTask(this.task);
  @override
  List<Object?> get props => [task];
}
