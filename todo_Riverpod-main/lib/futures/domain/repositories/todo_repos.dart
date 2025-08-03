import 'package:dars_riverpod/futures/domain/entities/todo_entitiy.dart';

abstract class TodoRepository {
  List<TodoEntity> getTodos();
  void addTodo(TodoEntity todo);
  void toggleTodo(String id);
  void deleteTodo(String id);
}
