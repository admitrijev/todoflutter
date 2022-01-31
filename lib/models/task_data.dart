import 'dart:collection';

import 'package:flutter/material.dart';
import 'task.dart';

class TaskData extends ChangeNotifier {

  final List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int getTasksAmount() {
    return _tasks.length;
  }

  int getDoneAmount() {
    int doneAmount = 0;
    for (var i = 0; i < getTasksAmount(); i++) {
      if (_tasks[i].isDone) {
        doneAmount++;
      }
    }
    return doneAmount;
  }

  void deleteCompletedTasks() {
    var toRemove = [];
    for (var task in _tasks) {
      if (task.isDone) {
        toRemove.add(task);
      }
    }

    for (var task in toRemove) {
      _tasks.remove(task);
    }
    notifyListeners();
  }

  Task createTask() {
    return Task(name: '', isNew: true);
  }

  void addTask([Task? taskToAdd]) {
    _tasks.add(taskToAdd?? createTask());
    notifyListeners();
  }

  void popTask(taskToRemove) {
    _tasks.remove(taskToRemove);
    notifyListeners();
  }
}