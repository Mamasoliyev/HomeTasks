import 'package:flutter/material.dart';
import 'package:getx_darsi/screens/card_screen.dart';
import 'package:getx_darsi/screens/product_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    ProductScreen(),
    CartScreen(),
    Center(child: Text("Fovourite not found")),
    Center(child: Text("Profil not found")),
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.shopping_cart,
    Icons.favorite_border,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: pages[selectedIndex],

      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(icons.length, (index) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.white24,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icons[index],
                  color: isSelected ? Colors.black : Colors.white70,
                  size: 24,
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
