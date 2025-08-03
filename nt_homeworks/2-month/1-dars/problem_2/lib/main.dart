import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:problem_2/CupertinoDesignPage.dart';
import 'package:problem_2/MaterialDesignPage.dart';

void main() {
  runApp(MyPlatformApp());
}

class MyPlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Platform Chooser', home: PlatformChooserPage());
  }
}

class PlatformChooserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Platform')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Open Material (Android)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MaterialDesignPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Open Cupertino (iOS)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CupertinoDesignPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
