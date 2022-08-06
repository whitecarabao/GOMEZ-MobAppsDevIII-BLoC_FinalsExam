import 'package:bloc_finals_exam/bloc/tasks_bloc/task_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/task.dart';

part 'tasks_event.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TaskStorage> {
  TasksBloc()
      : super(const TaskStorage(
          tasks: {},
        )) {
    on<TasksEvent>((event, emit) {
      if (event is AddTask) {
        emit(super.state.create(event.task));
      }
      if (event is EditTask) {
        super.state.update(event.task);
        emit(super.state.update(event.task));
      }
      if (event is RecycleTask) {
        emit(super.state.recycle(event.task));
      }
      if (event is DeleteTask) {
        emit(super.state.delete(event.task));
      }
    });
  }

  @override
  TaskStorage? fromJson(Map<String, dynamic> json) {
    return TaskStorage.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskStorage state) {
    return state.toMap();
  }
}
