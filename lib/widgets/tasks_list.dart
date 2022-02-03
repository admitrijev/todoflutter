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
                    DynamicBar(doneAmount: doneAmount, callbackDeleteCompleted: (){
                      taskData.deleteCompletedTasks();
                    }),
                  ],
                );
              }

              //Adds an extra index to render the title
              index -= 1;

              Task task = taskData.tasks[index];
              final textEditingController = TextEditingController();
              textEditingController.text = task.description;
              return Focus(
                onFocusChange: (hasFocus) {
                  if(!hasFocus) {
                    if (textEditingController.text == '') {
                      taskData.popTask(task);
                    } else {
                      task.description = textEditingController.text;
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: index + 1 == taskData.getTasksAmount() ? 80.0 : 0
                  ),
                  child: TaskTile(
                    textEditingController: textEditingController,
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DynamicBar extends StatelessWidget {
  const DynamicBar({
    Key? key,
    required this.doneAmount,
    required this.callbackDeleteCompleted,
  }) : super(key: key);

  final int doneAmount;
  final void Function()? callbackDeleteCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [
        Text(
          '$doneAmount marked as done',
          style: kDefaultSecondaryTextStyle
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: doneAmount > 0? 1 : 0,
          child: Row(
            children: <Widget> [
              Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: const Text(
                  '●',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 8
                  ),
                ),
              ),
              TextButton(
                onPressed: callbackDeleteCompleted,
                child: const Text(
                    'Clear',
                    style: kDefaultSecondaryTextStyle
                ),
              ),
            ],
          ),
        )
      ]
    );
  }
}
