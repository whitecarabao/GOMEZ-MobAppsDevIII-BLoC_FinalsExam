import 'package:bloc_finals_exam/app_themes.dart';
import 'package:bloc_finals_exam/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tasks_bloc/task_storage.dart';
import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../screens/recycle_bin_screen.dart';
import '../screens/tabs_screen.dart';

class TasksDrawer extends StatelessWidget {
  const TasksDrawer({Key? key}) : super(key: key);

  _switchToDarkTheme(BuildContext context) {
    context.read<ThemeCubit>().toggle();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            BlocBuilder<TasksBloc, TaskStorage>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.folder_special),
                  title: const Text('My Tasks'),
                  trailing: Text(
                    '${state.pendingTasks.length} | ${state.completedTasks.length}',
                  ),
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    TabsScreen.path,
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TaskStorage>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Recycle Bin'),
                  trailing: Text('${state.removedTasks.length}'),
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    RecycleBinScreen.path,
                  ),
                );
              },
            ),
            const Divider(),
            const Expanded(child: SizedBox()),
            BlocBuilder<ThemeCubit, AppTheme>(
              builder: (context, state) {
                return ListTile(
                  leading: Switch(
                    value: state == AppTheme.darkMode,
                    onChanged: (newValue) => _switchToDarkTheme(context),
                  ),
                  title: const Text('Switch to Dark Theme'),
                  onTap: () => _switchToDarkTheme(context),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
