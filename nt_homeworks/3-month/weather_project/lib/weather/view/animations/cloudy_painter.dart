import 'package:flutter/material.dart';
import 'package:weather_project/core/app/custom_paints/cloud_painter.dart';

class CloudyPainterWidget extends StatefulWidget {
  const CloudyPainterWidget({super.key});

  @override
  State<CloudyPainterWidget> createState() => _CloudyPainterWidgetState();
}

class _CloudyPainterWidgetState extends State<CloudyPainterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 190, bottom: 200),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: CloudPainter(_animation.value),
            child: Container(),
          );
        },
      ),
    );
  }
}
