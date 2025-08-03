import 'package:flutter/material.dart';

class MaterialDesignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Welcome")),
        body: Center(
          child: Text(
            "Flutter makes app development fun",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
