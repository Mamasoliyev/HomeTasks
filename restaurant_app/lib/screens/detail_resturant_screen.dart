import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_app/widgets/produc_widget.dart';

class DetailResturantScreen extends StatefulWidget {
  final List<Map<String, dynamic>> foods;
  final Map<String, dynamic> restaurant;
  const DetailResturantScreen({
    super.key,
    required this.foods,
    required this.restaurant,
  });

  @override
  State<DetailResturantScreen> createState() => _DetailResturantScreenState();
}

class _DetailResturantScreenState extends State<DetailResturantScreen> {
  @override
  Widget build(BuildContext context) {
    log(widget.foods.length.toString());

    return Scaffold(
      appBar: AppBar(title: Text("Restaurant Foods")),
      body: SafeArea(
        child: GridView.builder(
          itemCount: widget.foods.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.63,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(15),
          itemBuilder: (context, index) {
            log(widget.foods[index]['name'] ?? 'No Name');

            return ProductWidget(
              food: widget.foods[index],
              restaurant: widget.restaurant,
            );
          },
        ),
      ),
    );
  }
}
