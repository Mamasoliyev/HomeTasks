// lib/features/todo/repositories/local_task_repository.dart

import 'task_repository.dart';
import '../models/task.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  List<Task> getAllTasks() => _tasks;

  @override
  void addTask(Task task) => _tasks.add(task);

  @override
  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) _tasks[index] = task;
  }

  @override
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
  }
}
