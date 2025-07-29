import 'package:bloc_lesson1/cubits/counter_cubit/counter_cubit.dart';
import 'package:bloc_lesson1/cubits/counter_cubit/counter_state.dart';
import 'package:bloc_lesson1/cubits/todo_cubit/todo_cubit.dart';
import 'package:bloc_lesson1/cubits/todo_cubit/todo_state.dart';
import 'package:bloc_lesson1/data/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<TodoCubit>(
                context,
              ).addTodo(TodoModel(name: "Uxlashim kerak ", owner: "Sunnat"));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.todos.isEmpty) {
            return Center(child: Text("No todos"));
          }
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return ListTile(
                title: Text(todo.name.toString()),
                subtitle: Text(todo.owner),
              );
            },
          );
        },
      ),
    );
  }
}
