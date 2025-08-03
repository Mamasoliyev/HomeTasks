import 'package:flutter/material.dart';
import 'package:weather_project/weather/models/rain_drop.dart';

class RainPainter extends CustomPainter {
  final List<RainDrop> rainDrops;
  final Paint rainPaint;

  RainPainter(this.rainDrops)
    : rainPaint =
          Paint()
            ..color = Colors.white.withValues(alpha: 0.6)
            ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    for (var drop in rainDrops) {
      canvas.drawLine(
        Offset(drop.x, drop.y),
        Offset(drop.x, drop.y + drop.length),
        rainPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
