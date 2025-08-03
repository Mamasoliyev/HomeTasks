import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_project/core/app/custom_paints/snow_painter.dart';
import 'package:weather_project/weather/models/snow_flake_model.dart';

class SnowAnimation extends StatefulWidget {
  const SnowAnimation({super.key});

  @override
  State<SnowAnimation> createState() => _SnowAnimationState();
}

class _SnowAnimationState extends State<SnowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Snowflake> snowflakes;
  final int flakeCount = 100;

  @override
  void initState() {
    super.initState();

    final random = Random();
    snowflakes = List.generate(flakeCount, (_) {
      return Snowflake(
        x: random.nextDouble() * 400,
        y: random.nextDouble() * 800,
        radius: 2 + random.nextDouble() * 3,
        speedY: 1 + random.nextDouble() * 2,
      );
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(() {
      setState(() {
        for (var flake in snowflakes) {
          flake.y += flake.speedY;
          if (flake.y > MediaQuery.of(context).size.height) {
            flake.y = 0;
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
    return CustomPaint(painter: SnowPainter(snowflakes), child: Container());
  }
}
