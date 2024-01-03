import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todolist/ui/add_todo_screen.dart';
import 'package:todolist/hive_model/todo.dart';
import 'package:todolist/ui/widget/todo_item.dart';

import '../main.dart';

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
      body: Column(
        children: [
          Center(
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16), // 달력 전체의 시작 날짜
              lastDay: DateTime.utc(2030, 3, 14), // 달력 전체의 마지막 날짜
              focusedDay: DateTime.now(), // 달력에서 선택될 날짜
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: ListView(
                children: todos.values
                    .map((e) => TodoItem(
                          todo: e,
                          onTap: (todo) async {
                            todo.isDone = !todo.isDone;
                            await todo.save();
            
                            setState(() {});
                          },
                          onDelete: (todo) async {
                            await todo.delete();
                            setState(() {});
                          },
                        ))
                    .toList()),
          ),
        ],
      ),
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
