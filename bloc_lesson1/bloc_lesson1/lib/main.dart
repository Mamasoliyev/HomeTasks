import 'package:bloc_lesson1/cubits/advice_cubit/advice_cubit.dart';
import 'package:bloc_lesson1/cubits/counter_cubit/counter_cubit.dart';
import 'package:bloc_lesson1/cubits/cubit/emoji_cubit.dart';
import 'package:bloc_lesson1/cubits/todo_cubit/todo_cubit.dart';
import 'package:bloc_lesson1/presentation/screens/advice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
  for (var element in KompaniyaTuri.values) {
    print(element.name);
  }
}

enum KompaniyaTuri {
  yakkaTadbirkorlik("Yakka Tadbirkorlik",3),
  sherikchilik("Sherikchilik",2),
  korporatsiya("Korporatsiya",3),
  masuliyatiCheklanganJamiyat("Mas'uliyati Cheklangan Jamiyat",5);

  // A'zolar
  final String matn;
  final int nimadir;
  const KompaniyaTuri(this.matn, this.nimadir);
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TodoCubit()),
          BlocProvider(create: (context) => CounterCubit()),
          BlocProvider(create: (context) => EmojiCubit()),
          BlocProvider(create: (context) => AdviceCubit(),)
        ],

        child: AdviceScreen(),
      ),
    );
  }
}
