// lib/features/todo/filters/pending_task_filter.dart
import 'task_filter.dart';
import '../models/task.dart';

class PendingTaskFilter implements TaskFilter {
  @override
  List<Task> filter(List<Task> tasks) =>
      tasks.where((task) => !task.isCompleted).toList();
}
