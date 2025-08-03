import 'dart:developer';

import 'package:flutter/material.dart';

class WatermelonScreen extends StatelessWidget {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    log(MediaQuery.of(context).size.width.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Home"),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 10),
        actions: [
          IconButton.filled(
            tooltip: "Ob-havo",
            color: Colors.amber,
            style: IconButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {},
            icon: Icon(Icons.cloud_circle),
          ),
          // SizedBox(width: 30),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TarVuzGa MarHaMaT",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.flip(flipX: true, child: halfWaterMelon()),
              halfWaterMelon(),
            ],
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          log("Icon pressed");
          counter++;
          log(counter.toString());
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          child: Icon(Icons.add, size: 25, color: Colors.white),
        ),
      ),
    );
  }
}

Container fullStop() {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
  );
}

Column generateDots(int dotsCount) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 30,
    children: List.generate(dotsCount, (index) => fullStop()),
  );
}

Container halfWaterMelon() {
  return Container(
    // transform: Matrix4.rotationZ(0),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.horizontal(right: Radius.circular(200)),
      border: Border(right: BorderSide(color: Colors.green, width: 12)),
    ),
    padding: EdgeInsets.all(40),
    alignment: Alignment.bottomLeft,
    height: 400,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        generateDots(8),
        generateDots(7),
        generateDots(6),
        generateDots(5),
      ],
    ),
  );
}
