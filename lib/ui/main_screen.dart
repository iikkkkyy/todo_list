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

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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
              headerStyle: const HeaderStyle(
                formatButtonVisible: true
              ),
              calendarBuilders: CalendarBuilders(),
              firstDay: DateTime.utc(2010, 10, 16), // 달력 전체의 시작 날짜
              lastDay: DateTime.utc(2030, 3, 14), // 달력 전체의 마지막 날짜
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
              // 달력에서 선택될 날짜
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
