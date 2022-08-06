import 'package:bloc_finals_exam/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import 'add_edit_task.dart';
import 'popup_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);

  final Task task;

  _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddEditTask(task: task),
        ),
      ),
    ).then((result) {
      if (result != null) {
        context.read<TasksBloc>().add(EditTask(result as Task));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              task.isFavorite == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration:
                            task.isDone! ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text(
                      DateFormat()
                          .add_yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.createdAt!)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted!
                    ? null
                    : (value) {
                        context
                            .read<TasksBloc>()
                            .add(EditTask(task.copyWith(isDone: value)));
                      }),
            PopupMenu(
              task: task,
              editCallback: () {
                Navigator.pop(context);
                _editTask(context);
              },
              likeOrDislikeCallback: () {
                context.read<TasksBloc>().add(
                      EditTask(
                        task.copyWith(isFavorite: !task.isFavorite!),
                      ),
                    );
              },
              cancelOrDeleteCallback: () {
                if (task.isDeleted ?? false) {
                  context.read<TasksBloc>().add(DeleteTask(task));
                } else {
                  context.read<TasksBloc>().add(RecycleTask(task));
                }
              },
              restoreTaskCallback: () {
                context.read<TasksBloc>().add(
                      EditTask(task.copyWith(isDeleted: false)),
                    );
              },
            ),
          ],
        ),
      ],
    );
  }
}
