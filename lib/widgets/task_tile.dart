import 'package:flutter/material.dart';
import 'package:todoapp/const.dart';

class TaskTile extends StatelessWidget {

  final String taskTitle;
  final bool isChecked;
  final bool isNew;
  final bool isLast;
  final Function(bool?) checkboxCallback;
  final Function(String?) callbackTextChanged;

  const TaskTile({Key? key, required this.taskTitle, required this.isChecked, required this.isLast, required this.isNew, required this.checkboxCallback, required this.callbackTextChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0.0),
        horizontalTitleGap: 0,
        leading: TaskTileCheckbox(isChecked: isChecked, checkboxCallback: checkboxCallback),
        title: TaskTileBody(callbackTextChanged: callbackTextChanged, isNew: isNew, isLast: isLast, taskTitle: taskTitle, isChecked: isChecked),
      ),
    );
  }
}

class TaskTileBody extends StatelessWidget {
  const TaskTileBody({
    Key? key,
    required this.callbackTextChanged,
    required this.isNew,
    required this.isLast,
    required this.taskTitle,
    required this.isChecked,
  }) : super(key: key);

  final Function(String? p1) callbackTextChanged;
  final bool isNew;
  final bool isLast;
  final String taskTitle;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    textEditingController.text = taskTitle;
    textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: textEditingController.text.length));

    return Container(
      margin: EdgeInsets.only(
        bottom: isLast ? 80.0 : 0
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 1.0,
              color: Colors.grey,
          ),
        ),
      ),
      child: TextField(
        onChanged: callbackTextChanged,
        autofocus: isNew,
        controller: textEditingController,
        maxLines: null,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(
          color: isChecked? Colors.grey.shade800 : Colors.white,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}

class TaskTileCheckbox extends StatelessWidget {
  const TaskTileCheckbox({
    Key? key,
    required this.isChecked,
    required this.checkboxCallback,
  }) : super(key: key);

  final bool isChecked;
  final Function(bool? p1) checkboxCallback;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.transparent,
      checkColor: kDefaultAccentColor,
      shape: const CircleBorder(),
      side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(
          width: 1.0,
          color: kDefaultAccentColor
        ),
      ),
      value: isChecked,
      visualDensity: VisualDensity.compact,
      onChanged: checkboxCallback,
    );
  }
}