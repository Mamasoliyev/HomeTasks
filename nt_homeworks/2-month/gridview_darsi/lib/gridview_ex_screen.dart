import 'dart:developer';

import 'package:flutter/material.dart';

class GridviewExScreen extends StatelessWidget {
  const GridviewExScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500 ,
            crossAxisSpacing: 50,
            mainAxisSpacing: 50,
            // mainAxisExtent: 500,
          ),
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 3,
          //   crossAxisSpacing: 30,
          //   mainAxisExtent: 100,
          //   mainAxisSpacing: 30,
          // ),
          children: [
            Container(color: Colors.amber, width: 300, height: 300),
            Container(color: Colors.red, width: 300, height: 300),
            Container(color: Colors.blue, width: 300, height: 300),
            Container(color: Colors.pink, width: 300, height: 300),
            Container(color: Colors.black, width: 300, height: 300),
            Container(color: Colors.green, width: 300, height: 300),
            Container(color: Colors.teal, width: 300, height: 300),
            Container(color: Colors.indigoAccent, width: 300, height: 300),
            Container(color: Colors.yellow, width: 300, height: 300),
          ],
        ),
      ),
    );
  }
}
