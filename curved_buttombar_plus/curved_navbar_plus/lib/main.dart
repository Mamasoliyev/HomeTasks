import 'package:curved_navbar_plus/curved_navbar_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Page $_index")),
        bottomNavigationBar: CurvedNavBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          icons: const [
            Icons.home,
            Icons.fastfood,
            Icons.bar_chart,
            Icons.person,
          ],
          labels: const ["Home", "Food", "Stats", "Profile"],
        ),
      ),
    );
  }
}
