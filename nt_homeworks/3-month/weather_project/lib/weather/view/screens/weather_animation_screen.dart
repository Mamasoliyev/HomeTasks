import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_project/weather/models/rain_drop.dart';
import 'package:weather_project/core/app/custom_paints/rain_painter.dart';

class RainAnimation extends StatefulWidget {
  const RainAnimation({super.key});

  @override
  State<RainAnimation> createState() => _RainAnimationState();
}

class _RainAnimationState extends State<RainAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<RainDrop> rainDrops;
  final int dropCount = 100;

  @override
  void initState() {
    super.initState();

    final random = Random();
    rainDrops = List.generate(dropCount, (_) {
      return RainDrop(
        x: random.nextDouble() * 400,
        y: random.nextDouble() * 800,
        length: 10 + random.nextDouble() * 20,
        speed: 2 + random.nextDouble() * 4,
      );
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(() {
      setState(() {
        for (var drop in rainDrops) {
          drop.y += drop.speed;
          if (drop.y > MediaQuery.of(context).size.height) {
            drop.y = 0;
          }
        }
      });
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: RainPainter(rainDrops), child: Container());
  }
}
