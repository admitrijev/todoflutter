import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/const.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/task_data.dart';
import 'task_tile.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Consumer<TaskData>(
        builder: (context, taskData, child) {
          return ListView.builder(
            itemCount: taskData.getTasksAmount() + 1,
            itemBuilder: (context, index) {
              int doneAmount = taskData.getDoneAmount();
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    const Text(
                      'Tasks',
                      style: kDefaultTitleStyle
                    ),
                    Row(
                      children: <Widget> [
                        Container(
                          margin: const EdgeInsets.only(top: 10.0, left: 5.0, bottom: 20.0),
                          child: Text(
                            '$doneAmount marked as done',
                            style: kDefaultSecondaryTextStyle
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0, left: 15.0, bottom: 20.0),
                          child: const Text(
                            '●',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                          child: TextButton(
                            onPressed: () {
                              taskData.deleteCompletedTasks();
                            },
                            child: const Text(
                              'Clear',
                              style: kDefaultSecondaryTextStyle
                            ),
                          ),
                        ),
                      ]
                    ),
                  ],
                );
              }
              //Adds an extra index to render the title
              index -= 1;

              Task task = taskData.tasks[index];
              return Focus(
                onFocusChange: (hasFocus) {
                  if(!hasFocus && task.name == '') {
                    taskData.popTask(task);
                  }
                },
                child: TaskTile(
                  taskTitle: task.name,
                  isChecked: task.isDone,
                  isNew: task.isNew,
                  callbackTextChanged: (String? value) {
                    setState(() {
                      task.setNewDescription(value);
                      task.setAsNotNew();
                    });
                  },
                  checkboxCallback: (bool? value) {
                    setState(() {
                      task.toggleDone();
                    });
                  }
                ),
              );
            },
          );
        },
      ),
    );
  }
}
