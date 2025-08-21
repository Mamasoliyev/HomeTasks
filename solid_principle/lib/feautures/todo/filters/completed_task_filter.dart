// lib/features/todo/filters/completed_task_filter.dart
import 'task_filter.dart';
import '../models/task.dart';

class CompletedTaskFilter implements TaskFilter {
  @override
  List<Task> filter(List<Task> tasks) =>
      tasks.where((task) => task.isCompleted).toList();
}
