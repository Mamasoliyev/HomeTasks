import 'package:flutter/material.dart';

class GridviewCustomScreen extends StatelessWidget {
  const GridviewCustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.custom(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
        ),
        // childrenDelegate: SliverChildListDelegate(
        //   List.generate(100, (index) {
        //     return Container(
        //       color: Colors.primaries[index % Colors.primaries.length],
        //       child: Center(child: Text("Item $index")),
        //     );
        //   }),
        // ),
        // childrenDelegate: SliverChildBuilderDelegate(childCount: 150, (
        //   context,
        //   index,
        // ) {
        //   return Container(
        //     color: Colors.primaries[index % Colors.primaries.length],
        //     child: Center(child: Text("Item $index")),
        //   );
        // }),
        childrenDelegate: SliverChildListDelegate.fixed([
          Container(color: Colors.amber, width: 300, height: 300),
          Container(color: Colors.red, width: 300, height: 300),
          Container(color: Colors.blue, width: 300, height: 300),
          Container(color: Colors.pink, width: 300, height: 300),
          Container(color: Colors.black, width: 300, height: 300),
          Container(color: Colors.green, width: 300, height: 300),
          Container(color: Colors.teal, width: 300, height: 300),
          Container(color: Colors.indigoAccent, width: 300, height: 300),
          Container(color: Colors.yellow, width: 300, height: 300),
        ]),
      ),
    );
  }
}
