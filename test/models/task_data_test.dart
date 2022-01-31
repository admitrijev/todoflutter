import 'package:test/test.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/task_data.dart';

void main() {

  test('Function must add a new task', () {
    final taskData = TaskData();
    expect(taskData.getTasksAmount(), 0);

    taskData.addTask();
    expect(taskData.getTasksAmount(), 1);
  });

  test('Function must return correct tasks amount', () {
    final taskData = TaskData();

    taskData.addTask();
    taskData.addTask();
    taskData.addTask();
    expect(taskData.getTasksAmount(), 3);
  });

  test('Function must pop the specific task', () {
    final taskData = TaskData();
    Task taskToDelete = Task(name: 'test', isDone: true);
    taskData.addTask(taskToDelete);
    taskData.addTask();

    taskData.popTask(taskToDelete);
    expect(taskData.getTasksAmount(), 1);
  });

  test('Function must delete all tasks marked as done', () {
    final taskData = TaskData();
    taskData.addTask(Task(name: 'test', isDone: true));
    taskData.addTask(Task(name: 'test', isDone: false));
    taskData.addTask(Task(name: 'test', isDone: true));

    taskData.deleteCompletedTasks();
    expect(taskData.getTasksAmount(), 1);
  });

  test('Function must return amount of tasks marked as done', () {
    final taskData = TaskData();
    taskData.addTask(Task(name: 'test', isDone: true));
    taskData.addTask(Task(name: 'test', isDone: false));
    taskData.addTask(Task(name: 'test', isDone: true));

    expect(taskData.getDoneAmount(), 2);
  });
}