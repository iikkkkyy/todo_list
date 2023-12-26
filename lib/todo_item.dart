import 'package:flutter/material.dart';
import 'package:todolist/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text('${todo.dateTime}'),
    );
  }
}
