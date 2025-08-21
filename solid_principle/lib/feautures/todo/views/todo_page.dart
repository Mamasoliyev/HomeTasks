// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:solid_principle/feautures/todo/controllers/task_controller.dart';
import 'package:solid_principle/feautures/todo/models/task.dart';




class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final TaskController controller = GetIt.I<TaskController>();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tasks = controller.getTasks();

    return Scaffold(
      appBar: AppBar(title: const Text("SOLID ToDo")),
      body: ListView(
        children: tasks
            .map(
              (task) => ListTile(
                title: Text(task.title),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      task.isCompleted = value ?? false;
                      controller.updateTask(task);
                    });
                  },
                ),
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final text = _textController.text;
          if (text.isNotEmpty) {
            setState(() {
              controller.addTask(
                Task(id: DateTime.now().toString(), title: text),
              );
              _textController.clear();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _textController,
          decoration: const InputDecoration(hintText: "Yangi vazifa..."),
        ),
      ),
    );
  }
}
