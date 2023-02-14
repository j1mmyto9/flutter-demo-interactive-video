import 'package:flutter/material.dart';

class QTextField extends StatelessWidget {
  const QTextField(
      {super.key,
      required this.func,
      this.onEditComplete,
      this.focusNode,
      this.initValue});

  final Function(String) func;
  final VoidCallback? onEditComplete;
  final FocusNode? focusNode;
  final String? initValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.all(2),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      child: TextFormField(
        cursorColor: Colors.black,
        onEditingComplete: onEditComplete,
        focusNode: focusNode,
        initialValue: initValue,
        decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none),
        style: const TextStyle(fontSize: 16, color: Colors.black),
        onChanged: (value) => func(value),
      ),
    );
  }
}
