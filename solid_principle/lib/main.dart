import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:solid_principle/feautures/todo/controllers/task_controller.dart';
import 'package:solid_principle/feautures/todo/repositories/local_task_repository.dart';
import 'package:solid_principle/feautures/todo/repositories/task_repository.dart';
import 'package:solid_principle/feautures/todo/views/todo_page.dart';

void main() {
  final getIt = GetIt.instance;

  // DIP: interfeysga implementatsiya bog‘laymiz
  getIt.registerLazySingleton<TaskRepository>(() => LocalTaskRepository());
  getIt.registerLazySingleton<TaskController>(
    () => TaskController(getIt<TaskRepository>()),
  );

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLID ToDo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        primaryColorDark: Colors.black,
      ),
      home: const ToDoPage(),
    );
  }
}
