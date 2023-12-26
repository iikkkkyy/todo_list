import 'package:flutter/material.dart';
import 'package:todolist/create_screen.dart';
import 'package:todolist/todo.dart';

import 'main.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 리스트'),
      ),
      body: ListView(
          children: todos.values
              .map((todo) => ListTile(
                    title: Text(todo.title),
                    subtitle: Text('${todo.dateTime}'),
                  ))
              .toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateScreen()),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
