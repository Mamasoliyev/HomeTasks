import 'package:flutter/material.dart';

void main() {
  runApp(MyThirdApp());
}

class MyThirdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '3-shart ilovasi', home: FlutterInfoPage());
  }
}

class FlutterInfoPage extends StatefulWidget {
  @override
  _FlutterInfoPageState createState() => _FlutterInfoPageState();
}

class _FlutterInfoPageState extends State<FlutterInfoPage> {
  String message = "Flutter is awesome!";

  void _changeMessage() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("E'tibor bering"),
            content: Text('Matn o‘zgartirilsinmi?'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    message = "You clicked the icon!";
                  });
                  Navigator.pop(context);
                },
                child: Text("Ha"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Yo'q"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Flutter App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Flutter - bu Google tomonidan ishlab chiqilgan ochiq manbali UI framework bo‘lib, mobil, veb va desktop ilovalarni bir codebase orqali yaratishga imkon beradi.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue, size: 30),
              onPressed: _changeMessage,
              tooltip: 'Matnni o‘zgartirish',
            ),
          ],
        ),
      ),
    );
  }
}
