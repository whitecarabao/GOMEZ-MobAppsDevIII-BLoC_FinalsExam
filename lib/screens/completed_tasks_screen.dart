import 'package:bloc_finals_exam/bloc/tasks_bloc/task_storage.dart';
import 'package:bloc_finals_exam/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';
import '../test_data.dart';
import '../widgets/tasks_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasksList = TestData.completedTasks; //NO LONGER NEEDED :)
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
                    '${state.completedTasks.length} Tasks',
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
                    'No completed tasks at the moment, stop procrastinating and GYA off the couch!',
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return TasksList(tasksList: state.completedTasks);
              }
            },
          ),
        ],
      ),
    );
  }
}
