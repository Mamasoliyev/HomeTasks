import 'package:bloc_lesson1/cubits/advice_cubit/advice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AdviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Advice"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdviceCubit, AdviceState>(
                  builder: (context, state) {
                    if (state is AdviceLoadingState) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          color: Colors.white,
                        ),
                      );
                    } else if (state is AdviceLoadedState) {
                      return Text(
                        state.advice.advice.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      );
                    } else if (state is AdviceErrorState) {
                      return Text(
                        state.message,
                        style: TextStyle(color: Colors.red),
                      );
                    } else {
                      return Text(
                        "Maslahat olish uchun tugmani bosing.",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AdviceCubit>().fetchAdvice();
              },
              child: Text("Maslahat ber"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
