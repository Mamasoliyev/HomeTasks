// lib/features/todo/repositories/task_repository.dart

import '../models/task.dart';

/// Faqat o‘qish uchun
abstract class ReadOnlyTaskRepository {
  List<Task> getAllTasks();
}

/// Faqat yozish uchun
abstract class WriteOnlyTaskRepository {
  void addTask(Task task);
  void updateTask(Task task);
  void deleteTask(String id);
}

/// To‘liq repository (LSP + ISP)
abstract class TaskRepository
    implements ReadOnlyTaskRepository, WriteOnlyTaskRepository {}
