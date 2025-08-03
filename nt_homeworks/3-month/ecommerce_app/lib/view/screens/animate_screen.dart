import 'dart:async';
import 'dart:developer';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'dart:math' hide log;
import 'package:animate_do/animate_do.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Animatsiyalar extends StatefulWidget {
  const Animatsiyalar({super.key});

  @override
  State<Animatsiyalar> createState() => _AnimatsiyalarState();
}

class _AnimatsiyalarState extends State<Animatsiyalar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  double _angle = 0;
  double width = 100;
  double height = 100;
  double opacity = 1;
  bool onTapped = false;
  bool _isDown = false;
  int index = 0;
  final String _text = "Flutter’da animatsiya zo‘r!";
  String _displayed = "";
  int _i = 0;

  final String fullText = "Flutter’da animatsiya zo‘r!";
  String visibleText = "";
  int indeks = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween<double>(
      begin: 100,
      end: 350,
    ).animate(animationController);
    // animation = Tween<Offset>(
    //   begin: Offset.zero,
    //   end: Offset(-1, 0),
    // ).animate(animationController);
    // animationController.forward();
    Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (_i < _text.length) {
        setState(() {
          _displayed += _text[_i];
          _i++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void startTyping() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (index < fullText.length) {
        setState(() {
          visibleText += fullText[index];
          index++;
        });
      } else {
        timer.cancel(); // tugaganda to‘xtaydi
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _rotateIcon() {
    setState(() {
      _angle += 2 * pi; // 360° aylanish
    });
    // animationController.forward(from: 0);
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Square().fadeInLeft(),
                  const Square().fadeInUp(),
                  const Square().fadeInDown(),
                  const Square().fadeInRight(),
                ],
              ),
              Text(
                _displayed,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                    "Flutter",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  // .scale(delay: 300.ms)
                  // .slideX()
                  // .shakeY()
                  // .pulse()
                  .roulette(),

             SizedBox(
                height: 300, // yoki boshqa mos balandlik
                child: LiveList.options(
                  options: LiveOptions(
                    showItemInterval: Duration(milliseconds: 100),
                    showItemDuration: Duration(milliseconds: 300),
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index, animation) => FadeTransition(
                    opacity: animation,
                    child: ListTile(
                      title: Text(
                        'Item $index',
                        style: TextStyle(
                          color: Colors.white,
                        ), // qora fonda oq matn
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _angle * animationController.value,
                      child: child,
                    );
                  },
                  child: IconButton(
                    iconSize: 60,
                    icon: const Icon(Icons.settings),
                    onPressed: _rotateIcon,
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: animationController,
                builder: (context, child) => FlutterLogo(size: animation.value),
              ),
              SizedBox(
                height: 600,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      top: _isDown ? 400 : 100,
                      // left: MediaQuery.of(context).size.width / 2 - 60,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            onTapped = !onTapped;
                            if (onTapped) {
                              height = 200;
                              width = 200;
                              opacity = 0;
                            } else {
                              height = 100;
                              width = 100;
                              opacity = 1;
                            }
                            _isDown = !_isDown;
                            index++;
                            _rotateIcon();
                            log('Aylanish: $_angle radian');
                          });
                        },
                        child: AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _angle * animationController.value,
                              child: child,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            width: width,
                            height: height,
                            // transform: Matrix4.rotationZ(_angle),
                            // transformAlignment: Alignment.center,
                            color: Colors
                                .primaries[index % Colors.primaries.length],
                            alignment: Alignment.center,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 600),
                              opacity: opacity,
                              child: const Text(
                                'Nodirbek',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // AnimatedOpacity(
              //   opacity: opacity, // 0 - ko‘rinmaydi, 1 - to‘liq ko‘rinadi
              //   duration: Duration(seconds: 1),
              //   child: Container(
              //     width: 200,
              //     height: 200,
              //     color: Colors.blueAccent,
              //     alignment: Alignment.center,
              //     child: Text('Salom', style: TextStyle(color: Colors.white)),
              //   ),
              // ),

              // TweenAnimationBuilder(tween: Tween<double>(begin: 0, end: 1 ), duration: Duration(seconds: 1 ), builder: )
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: 1),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      onTapped = !onTapped;
                      if (onTapped) {
                        height = 200;
                        width = 200;
                        opacity = 0;
                      } else {
                        height = 100;
                        width = 100;
                        opacity = 1;
                      }
                      _angle += 3 * pi;
                      _isDown = !_isDown;
                      index++;
                      log('Aylanish: $_angle radian');
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    width: width,
                    height: height,
                    transform: Matrix4.rotationZ(_angle),
                    transformAlignment: Alignment.center,
                    color: Colors.primaries[index % Colors.primaries.length],
                    alignment: Alignment.center,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      opacity: opacity,
                      child: const Text(
                        'Nodirbek',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                builder: (context, value, child) {
                  return Padding(
                    padding: EdgeInsets.only(top: value * 1000),
                    child: Opacity(opacity: value, child: child),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Square extends StatelessWidget {
  const Square({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(width: 50, height: 50, color: const Color(0xff67549B));
  }
}
