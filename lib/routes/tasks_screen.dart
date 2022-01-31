import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todoapp/const.dart';
import 'package:todoapp/models/task_data.dart';
import 'package:todoapp/widgets/tasks_list.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  bool createNew = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget> [
         Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF242424),
                ]
              )
            ),
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: const TasksList(),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 100.0,
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 10.0, left: 10.0),
                    child: TextButton(
                        onPressed: () {
                          Provider.of<TaskData>(context, listen: false).popEmptyTasks();
                          Provider.of<TaskData>(context, listen: false).addTask();
                        },
                        child: const Text(
                          'Add a new task +',
                          style: TextStyle(
                            color: kDefaultAccentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}
