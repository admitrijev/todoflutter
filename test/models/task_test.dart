import 'package:test/test.dart';
import 'package:todoapp/models/task.dart';

void main() {
  Task createTestTask() {
    return Task(name: 'TaskName', isNew: true, isDone: false);
  }

  test('New description have to be set', () {
    final task = createTestTask();
    const String newDescription = 'New Description';

    task.setNewDescription(newDescription);
    expect(task.name, newDescription);
  });

  test('Must set isNew as false', () {
    final task = createTestTask();
    expect(task.isNew, true);

    task.setAsNotNew();
    expect(task.isNew, false);

    //Asserts that function doesn't work as a toggle
    task.setAsNotNew();
    expect(task.isNew, false);
  });

  test('Must toggle isDone state', () {
    final task = createTestTask();
    expect(task.isDone, false);

    task.toggleDone();
    expect(task.isDone, true);

    task.toggleDone();
    expect(task.isDone, false);
  });
}