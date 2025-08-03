import 'package:flutter/material.dart';
import 'package:gridview_darsi/gridview_extent_screen.dart';
import 'package:gridview_darsi/warmup.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WarmUpScreen(),
    );
  }
}
