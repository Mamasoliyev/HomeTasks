import 'package:bloc_lesson1/cubits/todo_cubit/todo_state.dart';
import 'package:bloc_lesson1/data/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState(todos: []));

  // ADD TODO
  void addTodo(TodoModel todo) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 3));
    emit(state.copyWith(isLoading: false));
    emit(state.copyWith(todos: [...state.todos, todo]));
  }
}
