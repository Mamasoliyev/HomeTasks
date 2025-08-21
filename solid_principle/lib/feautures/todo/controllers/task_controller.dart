// lib/features/todo/controllers/task_controller.dart

import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../filters/task_filter.dart';

class TaskController {
  final TaskRepository repository;

  TaskController(this.repository);

  void addTask(Task task) => repository.addTask(task);

  void updateTask(Task task) => repository.updateTask(task);

  void deleteTask(String id) => repository.deleteTask(id);

  List<Task> getTasks({TaskFilter? filter}) {
    final tasks = repository.getAllTasks();
    return filter != null ? filter.filter(tasks) : tasks;
  }
}
