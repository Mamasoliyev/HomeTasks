import 'dart:math' as Math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CustomPainters extends StatefulWidget {
  const CustomPainters({super.key});

  @override
  State<CustomPainters> createState() => _CustomPaintersState();
}

class _CustomPaintersState extends State<CustomPainters>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  ui.Image? image;
  static const _backgroundColor = Color(0xFFF15BB5);

  static const _colors = [Color(0xFFFEE440), Color(0xFF00BBF9)];

  static const _durations = [5000, 4000];

  static const _heightPercentages = [0.65, 0.66];

  @override
  void initState() {
    super.initState();
    _loadImage();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  Future<void> _loadImage() async {
    final data = await rootBundle.load('assets/images/eye2.png');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      image = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(painter: MyPainter(), size: const Size(200, 300)),

                  /// Eyes
                  /// Eyes
                  Positioned(
                    top: 70,
                    left: 44,
                    child: image == null
                        ? const CircularProgressIndicator() // yoki SizedBox.shrink()
                        : Row(
                            children: [
                              CustomPaint(
                                painter: RasmPainter(image!),
                                size: const Size(50, 50),
                              ),
                              const SizedBox(width: 10),
                              CustomPaint(
                                painter: RasmPainter(image!),
                                size: const Size(50, 50),
                              ),
                            ],
                          ),
                  ),

                  /// Custom shape
                  Positioned(
                    top: 150,
                    left: 80,
                    child: CustomPaint(
                      painter: MyPainter(),
                      size: const Size(30, 20),
                    ),
                  ),

                  /// Half Circle
                  Positioned(
                    top: 170,
                    left: 70,
                    child: CustomPaint(
                      painter: HalfCirclePainter(),
                      size: const Size(50, 50),
                    ),
                  ),
                ],
              ),
              CustomPaint(painter: MatnPainter(), size: const Size(100, 30)),
              CustomPaint(
                painter: TrianglePainter(),
                size: const Size(200, 200),
              ),

              /// Draw Image with CustomPainter
              const SizedBox(height: 30),
              Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 66,
                          child: CustomPaint(
                            painter: RectPainter(color: Colors.lightBlueAccent),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  children: [
                                    CustomPaint(
                                      painter: CirclePainter(
                                        color: Colors.white,
                                        radius: 26,
                                      ),
                                      size: Size(66, 66),
                                    ),
                                    Positioned(
                                      left: 7,
                                      child: CustomPaint(
                                        painter: CirclePainter(
                                          color: Colors.lightBlueAccent,
                                          radius: 23,
                                        ),
                                        size: Size(66, 66),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(width: 1),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .end, // vertikal markazga
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: List.generate(3, (index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CustomPaint(
                                              painter: StarPainter(),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: List.generate(4, (index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CustomPaint(
                                              painter: StarPainter(),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: List.generate(5, (index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CustomPaint(
                                              painter: StarPainter(),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 200),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 7,
                          child: CustomPaint(
                            painter: RectPainter(color: Colors.redAccent),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 66,
                          child: CustomPaint(
                            painter: RectPainter(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 7,
                          child: CustomPaint(
                            painter: RectPainter(color: Colors.redAccent),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 66,
                          child: CustomPaint(
                            painter: RectPainter(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .moveY(
                    begin: -3,
                    end: 3,
                    duration: 800.ms,
                    curve: Curves.easeInOutSine,
                  ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: WaveWidget(
                  size: Size(double.infinity, double.infinity),
                  config: CustomConfig(
                    colors: _colors,
                    durations: _durations,
                    heightPercentages: _heightPercentages,
                  ),
                  backgroundColor: _backgroundColor,
                  waveAmplitude: 0,
                ),
              ),
              SizedBox(height: 63),
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: CirclePainter(color: Colors.amber, radius: 140),
                    ),
                    // AnimatedBuilder(
                    //   animation: _controller,
                    //   builder: (context, child) {
                    //     double angle = (_controller.value * 2 * Math.pi);
                    //     return CustomPaint(
                    //       painter: LinePainter(angle: angle),
                    //       size: const Size(200, 200),
                    //     );
                    //   },
                    // ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final now = DateTime.now();
                        return CustomPaint(
                          size: const Size(300, 300),
                          painter: ClockPainter(time: now, radius: 140),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 63),

              CustomPaint(
                painter: StarPainter2(color: Colors.orange),
                size: const Size(100, 100),
              ),
              SizedBox(height: 63),
            ],
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime time;
  final double radius;

  ClockPainter({required this.time, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Sekund mili
    final secondAngle = (2 * Math.pi / 60) * time.second;
    final secondHand = Offset(
      center.dx + radius * 0.9 * Math.cos(secondAngle - Math.pi / 2),
      center.dy + radius * 0.9 * Math.sin(secondAngle - Math.pi / 2),
    );
    canvas.drawLine(
      center,
      secondHand,
      Paint()
        ..color = Colors.red
        ..strokeWidth = 2,
    );

    // Daqiqa mili
    final minuteAngle = (2 * Math.pi / 60) * time.minute;
    final minuteHand = Offset(
      center.dx + radius * 0.75 * Math.cos(minuteAngle - Math.pi / 2),
      center.dy + radius * 0.75 * Math.sin(minuteAngle - Math.pi / 2),
    );
    canvas.drawLine(
      center,
      minuteHand,
      Paint()
        ..color = Colors.blue
        ..strokeWidth = 5,
    );

    // Soat mili
    final hourAngle = (2 * Math.pi / 12) * (time.hour % 12 + time.minute / 60);
    final hourHand = Offset(
      center.dx + radius * 0.5 * Math.cos(hourAngle - Math.pi / 2),
      center.dy + radius * 0.5 * Math.sin(hourAngle - Math.pi / 2),
    );
    canvas.drawLine(
      center,
      hourHand,
      Paint()
        ..color = Colors.green
        ..strokeWidth = 6,
    );

    // Soat doirasi
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Soat chiziqchalari (12 ta)
    for (int i = 0; i < 12; i++) {
      final angle = (2 * Math.pi / 12) * i;
      final outer = Offset(
        center.dx + radius * Math.cos(angle),
        center.dy + radius * Math.sin(angle),
      );
      final inner = Offset(
        center.dx + (radius - 10) * Math.cos(angle),
        center.dy + (radius - 10) * Math.sin(angle),
      );
      canvas.drawLine(
        inner,
        outer,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 3,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class LinePainter extends CustomPainter {
  final double angle; // radians bo'lishi kerak

  LinePainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final length = size.width / 2;

    final endPoint = Offset(
      center.dx + length * Math.cos(angle),
      center.dy + length * Math.sin(angle),
    );

    canvas.drawLine(center, endPoint, paint);
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) =>
      oldDelegate.angle != angle;
}

class CirclePainter extends CustomPainter {
  Color color;
  double radius;

  CirclePainter({required this.color, required this.radius});
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Ellipse
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawOval(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Half circle
class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: 25,
      ),
      0,
      3.14,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Triangle
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Matn
class MatnPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: 'Nodirbek',
      style: const TextStyle(color: Colors.black, fontSize: 20),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, Offset(0, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Rasm
class RasmPainter extends CustomPainter {
  final ui.Image image;
  RasmPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final src = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    ); // asl rasm o'lchami
    final dst = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    ); // chiziladigan joy va o'lcham

    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RectPainter extends CustomPainter {
  final Color color;

  RectPainter({super.repaint, required this.color});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(0),
      ),
      Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawPath(
      Path()
        ..moveTo(size.width / 2, 0)
        ..lineTo(size.width * 0.15, size.height)
        ..lineTo(size.width, size.height * 0.4)
        ..lineTo(0, size.height * 0.4)
        ..lineTo(size.width * 0.85, size.height)
        ..close(),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StarPainter2 extends CustomPainter {
  final Color color;
  StarPainter2({this.color = Colors.amber});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double outerRadius = size.width / 2;
    final double innerRadius = outerRadius / 2.5;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Path path = Path();

    for (int i = 0; i < 10; i++) {
      final double angle = i * 36 * 3.1415926 / 180;
      final double radius = i.isEven ? outerRadius : innerRadius;
      final double x = center.dx + radius * Math.cos(angle);
      final double y = center.dy + radius * Math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
