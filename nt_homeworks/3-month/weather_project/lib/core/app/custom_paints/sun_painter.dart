import 'dart:math';

import 'package:flutter/material.dart';

class SunPainterWidget extends StatelessWidget {
  const SunPainterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsetsGeometry.only(
        right: width * 0.03,
        bottom: height * 0.65,
      ),
      child: CustomPaint(painter: SunPainter(), child: Container()),
    );
  }
}

class SunPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint =
        Paint()
          ..color = Colors.yellow.withValues(alpha: 0.8)
          ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 4);
    canvas.drawCircle(center, 50, sunPaint);

    final rayPaint =
        Paint()
          ..color = Colors.yellowAccent
          ..strokeWidth = 4;

    for (double i = 0; i < 360; i += 30) {
      final angle = i * pi / 180;
      final start = Offset(
        center.dx + cos(angle) * 60,
        center.dy + sin(angle) * 60,
      );
      final end = Offset(
        center.dx + cos(angle) * 80,
        center.dy + sin(angle) * 80,
      );
      canvas.drawLine(start, end, rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
