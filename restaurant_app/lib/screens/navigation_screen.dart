
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/screens/book_screen.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  static const path = "/navigation";
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const BookScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Sahifalar qayta yuklanmasin -> IndexedStack ishlatamiz
          IndexedStack(index: _currentIndex, children: _pages),

          /// Custom navigation bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),

                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,

                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/svgs/home.svg",
                      color: _currentIndex == 0 ? Colors.green : null,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/svgs/note.svg",
                      color: _currentIndex == 1 ? Colors.green : null,
                    ),
                    label: "Orders",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/svgs/profile.svg",
                      color: _currentIndex == 2 ? Colors.green : null,
                    ),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
