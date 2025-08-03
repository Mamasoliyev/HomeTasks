import 'package:flutter/material.dart';

void main() {
  runApp(MyFourthApp());
}

class MyFourthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Flutter App',
      home: InteractiveHomePage(),
    );
  }
}

class InteractiveHomePage extends StatefulWidget {
  @override
  _InteractiveHomePageState createState() => _InteractiveHomePageState();
}

class _InteractiveHomePageState extends State<InteractiveHomePage> {
  String message = "Hello, Flutter!";

  void updateMessage(String newText) {
    setState(() {
      message = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interactive Flutter App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: TextStyle(fontSize: 30, color: Colors.red)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up, color: Colors.green, size: 32),
                  onPressed: () => updateMessage("Button 1 Pressed!"),
                  tooltip: "Like",
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Icon(Icons.star, color: Colors.orange, size: 32),
                  onPressed: () => updateMessage("Button 2 Pressed!"),
                  tooltip: "Favorite",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
