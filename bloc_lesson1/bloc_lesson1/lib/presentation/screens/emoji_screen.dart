import 'package:bloc_lesson1/cubits/cubit/emoji_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmojiScreen extends StatelessWidget {
  const EmojiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<EmojiCubit, EmojiState>(
              builder: (context, state) {
                return Text(state.emoji!, style: TextStyle(fontSize: 100));
              },
            ),

            ElevatedButton(
              onPressed: () {
                context.read<EmojiCubit>().getEmoji();
              },
              child: Text("Generate"),
            ),
          ],
        ),
      ),
    );
  }
}
