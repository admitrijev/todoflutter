import 'package:flutter/material.dart';
import 'package:todoapp/const.dart';

class TaskTile extends StatelessWidget {

  final String taskTitle;
  final bool isChecked;
  final bool isNew;
  final Function(bool?) checkboxCallback;
  final Function(String?) callbackTextChanged;

  const TaskTile({Key? key, required this.taskTitle, required this.isChecked, required this.isNew, required this.checkboxCallback, required this.callbackTextChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        horizontalTitleGap: 0,
        leading: Checkbox(
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
        ),
        title: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
              ),
            ),
          ),
          child: TextField(
            onSubmitted: callbackTextChanged,
            autofocus: isNew,
            controller: TextEditingController(text: taskTitle),
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
        ),
      ),
    );
  }
}