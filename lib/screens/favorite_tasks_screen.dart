import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tasks_bloc/task_storage.dart';
import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../models/task.dart';
import '../test_data.dart';
import '../widgets/tasks_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasksList = TestData.favoriteTasks; //NO LONGER NEEDED :)
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
                    '${state.favoriteTasks.length} Tasks',
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
                    'No favorite/bookmarked tasks. <Lorem snarky commentus ipsum sarcasm>',
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return TasksList(tasksList: state.favoriteTasks);
              }
            },
          ),
        ],
      ),
    );
  }
}
