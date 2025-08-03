import 'package:flutter/material.dart';

class CloudPainter extends CustomPainter {
  final double dx;

  CloudPainter(this.dx);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.7)
          ..style = PaintingStyle.fill;

    final Offset base = Offset(size.width / 2 + dx, size.height / 3);

    // Draw cloud layers
    canvas.drawCircle(base.translate(-40, 0), 40, paint);
    canvas.drawCircle(base.translate(0, -20), 50, paint);
    canvas.drawCircle(base.translate(40, 0), 40, paint);
    canvas.drawOval(
      Rect.fromCenter(center: base, width: 120, height: 60),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CloudPainter oldDelegate) {
    return oldDelegate.dx != dx;
  }
}
