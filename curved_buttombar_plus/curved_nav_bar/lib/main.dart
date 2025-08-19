import 'package:flutter/material.dart';
import 'package:curved_navbar_plus/curved_navbar_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curved NavBar Plus Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text("🏠 Home Page", style: TextStyle(fontSize: 22))),
    Center(child: Text("🍔 Food Page", style: TextStyle(fontSize: 22))),
    Center(child: Text("📊 Stats Page", style: TextStyle(fontSize: 22))),
    Center(child: Text("👤 Profile Page", style: TextStyle(fontSize: 22))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Curved NavBar Example")),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        icons: const [
          Icons.home,
          Icons.fastfood,
          Icons.bar_chart,
          Icons.person,
        ],
        labels: const ["Home", "Food", "Stats", "Profile"],
      ),
      //  CurvedNavBarPlus(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: const [
      //     CurvedNavItem(icon: Icons.home, label: "Home"),
      //     CurvedNavItem(icon: Icons.fastfood, label: "Food"),
      //     CurvedNavItem(icon: Icons.bar_chart, label: "Stats"),
      //     CurvedNavItem(icon: Icons.person, label: "Profile"),
      //   ],
      // ),
    );
  }
}
