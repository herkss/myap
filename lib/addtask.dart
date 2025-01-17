import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  final void Function({required String todoText}) addTodo;
  const AddTask({super.key, required this.addTodo});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Add Task"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            autofocus: true,
            controller: todoText,
            decoration: const InputDecoration(hintText: '텍스트를 추가하세요'),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (todoText.text.isNotEmpty) {
                widget.addTodo(todoText: todoText.text);
              }
              todoText.clear();
            },
            child: const Text("추가"))
      ],
    );
  }
}
