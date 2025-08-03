import 'dart:developer';

import 'package:flutter/material.dart';

class GridviewCountScreen extends StatefulWidget {
  const GridviewCountScreen({super.key});

  @override
  State<GridviewCountScreen> createState() => _GridviewCountScreenState();
}

class _GridviewCountScreenState extends State<GridviewCountScreen> {
  ScrollController scrollController = ScrollController();
  bool _isVisible = false;

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    log(scrollController.position.pixels.toString());
    if (scrollController.position.pixels > 1500) {
      setState(() {
        _isVisible = true;
      });
    } else {
      _isVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isVisible
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.nights_stay),
            )
          : null,
      body: SafeArea(
        child: GridView.count(
          controller: scrollController,
          crossAxisCount: 4,
          children: List.generate(200, (index) {
            return Card(
              elevation: 15,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    "https://plus.unsplash.com/premium_photo-1675827055694-010aef2cf08f?q=80&w=2024&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  ),
                  Positioned(
                    left: 15,
                    right: 15,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Nature waterfall",
                      maxLines: 2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
