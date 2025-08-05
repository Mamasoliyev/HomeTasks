//navigation_page.dart
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/book_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/favourite_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/home_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/profile_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<Widget> pages = [
    const HomePage(),
     BookPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.book, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.transparent,
        height: 60,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
    );
  }
}
