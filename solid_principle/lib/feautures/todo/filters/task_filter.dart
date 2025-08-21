// lib/features/todo/filters/task_filter.dart
import '../models/task.dart';

abstract class TaskFilter {
  List<Task> filter(List<Task> tasks);
}
