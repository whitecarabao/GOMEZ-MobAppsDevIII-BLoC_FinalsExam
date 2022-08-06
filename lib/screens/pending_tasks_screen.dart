import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tasks_bloc/task_storage.dart';
import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../widgets/tasks_list.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<TasksBloc, TaskStorage>(
            builder: (context, state) {
              return Center(
                child: Chip(
                  label: Text(
                    '${state.pendingTasks.length} Pending | ${state.completedTasks.length} Completed',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<TasksBloc, TaskStorage>(
            builder: (context, state) {
              if (state.empty) {
                return const Center(
                    child: Text(
                  'No pending tasks at the moment, either you are really diligent, or so lazy you didn\'t even add a task.',
                  textAlign: TextAlign.center,
                ));
              } else {
                return TasksList(tasksList: state.pendingTasks);
              }
            },
          ),
        ],
      ),
    );
  }
}
