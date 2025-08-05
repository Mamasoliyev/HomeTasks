// favorite page
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Books"),
      ),
      body: const Center(
        child: Text("No favorite books yet."),
      ),
    );
  }
}