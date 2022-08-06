import 'package:bloc_finals_exam/models/task.dart';
import 'package:equatable/equatable.dart';

class TaskStorage extends Equatable {
  final Map<String, Task> tasks;
  const TaskStorage({required this.tasks});

/*
   Personal Notes
    ---------------
    Equatable is a library that helps you to compare two objects
    without dealing with the hash code issues and the equality operator

    Equatable is heavily used in BLoC programming because of the heavy
    reliance on matching properties rather than direct comparisons, 
    or else we'd need to use a LOT of lengthy override codes to achieve
    the same result.

    I extended Equatable to allow for the comparison of objects using props.
*/

/*
 The "factory" keyword is used to create the single instance of the class.
*/
  factory TaskStorage.fromMap(Map<String, dynamic> json) {
    return TaskStorage(
      tasks: fromJson(json),
    );
  }

/*
The "fromJson" method iterates over the json entries and returns a Map
that allows for easy access via key/value pairs.
*/
  static Map<String, Task> fromJson(Map<String, dynamic> json) {
    Map<String, Task> result = {};
    for (MapEntry entry in json.entries) {
      result[entry.key.toString()] = Task.fromMap(entry.value);
    }
    return result;
  }

/*
The "toMap" function is pretty straightforward. It iterates over the
tasks and converts it into a Map
*/

  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.from(
      tasks.map((key, value) => MapEntry(key.toString(), value.toMap())),
    );
  }

/*
Filtering functions that will output favorite tasks, pending tasks
and completed tasks by matching against their properties.
*/
  List<Task> get favoriteTasks {
    return tasks.values
        .where((element) =>
            (!(element.isDeleted ?? false) && (element.isFavorite ?? false)))
        .toList();
  }

  List<Task> get pendingTasks {
    return tasks.values
        .where((element) =>
            !(element.isDeleted ?? false) && !(element.isDone ?? false))
        .toList();
  }

  List<Task> get completedTasks {
    return tasks.values
        .where((element) =>
            !(element.isDeleted ?? false) && (element.isDone ?? false))
        .toList();
  }

  List<Task> get removedTasks {
    return tasks.values
        .where((element) => (element.isDeleted ?? false))
        .toList();
  }

  TaskStorage create(Task t) {
    /*
  Creates a new instance of the map since tasks is immutable
  */
    Map<String, Task> result = Map<String, Task>.from(tasks)..[t.id!] = t;

    return copyWith(tasks: result);
  }

  /*
  Does the same thing but ideally I'd run an existence check
  with result.containsKey(t.id!)==true
  */

  TaskStorage update(Task t) {
    /*
  Creates a new instance of the map since tasks is immutable
  */
    Map<String, Task> result = Map<String, Task>.from(tasks)..[t.id!] = t;

    return copyWith(tasks: result);
  }

  TaskStorage recycle(Task t) {
    /*
  Creates a new instance of the map since tasks is immutable
  */
    Map<String, Task> result = Map<String, Task>.from(tasks)
      ..[t.id!] = t.copyWith(isDeleted: true);

    return copyWith(tasks: result);
  }

  TaskStorage delete(Task t) {
    /*
  Creates a new instance of the map since tasks is immutable
  */
    Map<String, Task> result = Map<String, Task>.from(tasks);
    result.remove(t.id!);

    return copyWith(tasks: result);
  }

  bool get empty => tasks.isEmpty;

  @override
  List<Object?> get props => [tasks];

  TaskStorage copyWith({required Map<String, Task> tasks}) {
    return TaskStorage(tasks: tasks);
  }
}
