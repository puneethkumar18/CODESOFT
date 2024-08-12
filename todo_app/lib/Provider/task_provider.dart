import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _taskList = [];
  final List<Task> _completedTaskList = [];

  List<Task> get taskList => _taskList;
  List<Task> get compltedList => _completedTaskList;

  void addtask(Task task) {
    _taskList.add(task);
    notifyListeners();
  }

  List<Task> onTime(String str) {
    List<Task> tasks = [];
    _taskList.map(
      (task) {
        if (task.completeIn == str) {
          tasks.add(task);
        }
      },
    ).toList();
    return tasks;
  }

  List<Task> onQuery(String str, List<Task> list) {
    List<Task> tasks = [];
    list.map(
      (task) {
        if (task.name.contains(str)) {
          tasks.add(task);
        }
      },
    ).toList();
    return tasks;
  }

  removeTask(Task task) {
    _taskList.remove(task);
    notifyListeners();
  }

  completeTask(Task task) {
    _taskList.remove(task);
    var taskNew = task.copyWith(isCompleted: true);
    if (_completedTaskList.length > 5) {
      _completedTaskList.removeAt(0);
    }
    _completedTaskList.add(taskNew);
    notifyListeners();
  }
}
