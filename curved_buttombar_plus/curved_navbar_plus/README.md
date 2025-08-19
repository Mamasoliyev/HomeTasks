# curved_navbar_plus

A beautiful and customizable curved bottom navigation bar for Flutter.  
This package helps you to quickly add an animated curved navigation bar to your app.

---

## 🚀 Installation

Add dependency in your `pubspec.yaml`:

```yaml
dependencies:
  curved_navbar_plus: ^0.0.1

```
##Or install via command:

```yaml
dart pub add curved_navbar_plus
```

⚡ Usage

Import the package:

import 'package:curved_navbar_plus/curved_navbar_plus.dart';


Then use it inside your Scaffold:

import 'package:flutter/material.dart';
import 'package:curved_navbar_plus/curved_navbar_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text("Home")),
    Center(child: Text("Food")),
    Center(child: Text("Stats")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavBarPlus(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          CurvedNavItem(icon: Icons.home, label: "Home"),
          CurvedNavItem(icon: Icons.fastfood, label: "Food"),
          CurvedNavItem(icon: Icons.bar_chart, label: "Stats"),
          CurvedNavItem(icon: Icons.person, label: "Profile"),
        ],
      ),
    );
  }
}

🎨 Features

Curved design with smooth animation.

Dark & light theme support.

Customizable colors and icons.

Easy to integrate with Scaffold.