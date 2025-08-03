import 'package:dars_riverpod/futures/domain/entities/todo_entitiy.dart';
import 'package:dars_riverpod/futures/domain/repositories/todo_repos.dart';


class TodoRepositoryImpl implements TodoRepository {
  final List<TodoEntity> _todos = [];

  @override
  List<TodoEntity> getTodos() => List.unmodifiable(_todos);

  @override
  void addTodo(TodoEntity todo) {
    _todos.add(todo);
  }

  @override
  void toggleTodo(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(isDone: !todo.isDone);
    }
  }

  @override
  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
  }
}
