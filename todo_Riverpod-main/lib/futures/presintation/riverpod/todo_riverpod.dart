import 'package:dars_riverpod/futures/data/repositories/todo_repos_impl.dart';
import 'package:dars_riverpod/futures/domain/entities/todo_entitiy.dart';
import 'package:dars_riverpod/futures/domain/repositories/todo_repos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoRepoProvider = Provider<TodoRepository>((ref) {
  return TodoRepositoryImpl();
});

final todoListProvider = StateNotifierProvider<TodoNotifier, List<TodoEntity>>((ref) {
  return TodoNotifier(ref.read(todoRepoProvider));
});

class TodoNotifier extends StateNotifier<List<TodoEntity>> {
  final TodoRepository repo;

  TodoNotifier(this.repo) : super(repo.getTodos());

  void addTodo(String title) {
    final todo = TodoEntity(id: DateTime.now().toString(), title: title);
    repo.addTodo(todo);
    state = repo.getTodos();
  }

  void toggleTodo(String id) {
    repo.toggleTodo(id);
    state = repo.getTodos();
  }

  void deleteTodo(String id) {
    repo.deleteTodo(id);
    state = repo.getTodos();
  }
}
