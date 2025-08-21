// lib/features/todo/repositories/remote_task_repository.dart

import 'task_repository.dart';
import '../models/task.dart';

class RemoteTaskRepository implements TaskRepository {
  // Simulyatsiya uchun: serverga saqlanadigan ro‘yxat
  final List<Task> _remoteTasks = [];

  @override
  List<Task> getAllTasks() => _remoteTasks;

  @override
  void addTask(Task task) => _remoteTasks.add(task);

  @override
  void updateTask(Task task) {
    final index = _remoteTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) _remoteTasks[index] = task;
  }

  @override
  void deleteTask(String id) {
    _remoteTasks.removeWhere((task) => task.id == id);
  }
}
