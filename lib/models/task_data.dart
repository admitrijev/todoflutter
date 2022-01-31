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

  void popEmptyTasks() {
    var toRemove = <Task>[];
    for (var task in _tasks) {
      if (task.name == '') {
        toRemove.add(task);
      }
    }

    popTasksArray(toRemove);
    notifyListeners();
  }

  Task createTask() {
    return Task(name: '', isNew: true);
  }

  void addTask([Task? taskToAdd]) {
    _tasks.add(taskToAdd?? createTask());
    notifyListeners();
  }

  void popTasksArray(List<Task> arrayToDelete) {
    for (var task in arrayToDelete) {
      popTask(task);
    }
  }

  void popTask(taskToRemove) {
    _tasks.remove(taskToRemove);
    notifyListeners();
  }
}