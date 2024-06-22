import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final PopupMenuButton? trailing;
  final int index;

  const TodoCard(
      {super.key,
      this.title,
      this.subtitle,
      this.trailing,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text((index + 1).toString()),
      ),
      title: Text(title ?? "Hello Every Nyan"),
      subtitle: Text(subtitle ?? "Subtitle"),
      trailing: trailing,
    );
  }
}
