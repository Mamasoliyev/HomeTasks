import 'dart:developer';

import 'package:flutter/material.dart';

class GridviewBuilderScreen extends StatelessWidget {
  const GridviewBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        cacheExtent: 500,
        // itemCount: 150,
        itemCount: 150,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (BuildContext context, int index) {
          log("item qurildi: $index");
          return Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(child: Text("Item $index")),
          );
        },
      ),
    );
  }
}
