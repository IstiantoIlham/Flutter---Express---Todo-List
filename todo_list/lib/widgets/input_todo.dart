import 'package:flutter/material.dart';
import 'package:d_input/d_input.dart';

class InputTodo extends StatelessWidget {
  const InputTodo(
      {super.key,
      required this.title,
      required this.description,
      required this.onSubmit,
      required this.actionText});

  final TextEditingController title;
  final TextEditingController description;
  final VoidCallback onSubmit;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DInput(
          controller: title,
          title: "Title",
        ),
        const SizedBox(height: 12),
        DInput(
          controller: description,
          title: "Description",
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: onSubmit,
          child: Text(actionText),
        ),
      ],
    );
  }
}
