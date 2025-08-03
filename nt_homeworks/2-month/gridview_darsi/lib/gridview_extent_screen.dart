import 'package:flutter/material.dart';

class GridviewExtentScreen extends StatelessWidget {
  const GridviewExtentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.extent(
        
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: List.generate(150, (index) {
          return Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(child: Text("Item $index")),
          );
        }),
      ),
    );
  }
}
