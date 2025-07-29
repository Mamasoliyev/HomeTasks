// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_lesson1/data/models/todo_model.dart';

class TodoState {
  List<TodoModel> todos;
  String error;
  bool isLoading;

  TodoState({required this.todos, this.isLoading = false, this.error = ""});

  TodoState copyWith({List<TodoModel>? todos, String? error, bool? isLoading}) {
    return TodoState(
      todos: todos ?? this.todos,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
