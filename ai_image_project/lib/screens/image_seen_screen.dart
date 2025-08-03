import 'dart:async';

import 'package:ai_image_project/services/auth_service.dart';
import 'package:ai_image_project/services/storage_service.dart';
import 'package:flutter/material.dart';

class ImageSeenScreen extends StatefulWidget {
  final int slextedImage;
  const ImageSeenScreen({super.key, required this.slextedImage});

  @override
  State<ImageSeenScreen> createState() => _ImageSeenScreenState();
}

class _ImageSeenScreenState extends State<ImageSeenScreen> {
  late final Timer _timer;
  late final PageController _pageController;
  int deleteSelectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {});
      }
    });

    _pageController = PageController(initialPage: widget.slextedImage);
  }

  @override
  void dispose() {
    _timer.cancel();
    resetTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  bool pressed = false;
  Timer? resetTimer;

  void handless() {
    setState(() {
      pressed = true;
    });

    resetTimer?.cancel();

    resetTimer = Timer(Duration(seconds: 3), () {
      setState(() {
        pressed = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedContainer(
        duration: Duration(milliseconds: 400),

        color: pressed ? Colors.white : Colors.black,
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: AuthService().getUserImages(),

          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Hech qanday rasm yuklanmagan",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              );
            }

            final images = snapshot.data;

            return SafeArea(
              child: Column(
                children: [
                  pressed
                      ? Row(
                          spacing: 10,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: IconButton(
                                style: IconButton.styleFrom(
                                  minimumSize: Size(0, 0),

                                  backgroundColor: Colors.deepPurple,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios_new_outlined),
                              ),
                            ),
                            Spacer(),

                            IconButton(
                              style: IconButton.styleFrom(
                                minimumSize: Size(0, 0),
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                  animationStyle: AnimationStyle(
                                    curve: Curves.bounceIn,
                                    duration: Duration(milliseconds: 200),
                                  ),
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(10),
                                    ),
                                    title: Text(
                                      "Delete?",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 22,
                                      ),
                                    ),
                                    content: Text(
                                      "rasmni ochirsangiz umuman uni qaytarishni iloji bolmaydi",
                                      style: TextStyle(color: Colors.grey),
                                    ),

                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Cencel",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: () {
                                          StorageService().deleteImage(
                                            docId:
                                                images![deleteSelectedIndex]['docId'],
                                            imageUrl:
                                                images[deleteSelectedIndex]['imageUrl'],
                                          );

                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(Icons.delete_outline),
                            ),
                          ],
                        )
                      : SizedBox(height: 69),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: images?.length ?? 1,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                handless();
                                deleteSelectedIndex = index;
                              },
                              child: Image.network(
                                images?[index]['imageUrl'] ?? "",
                                fit: BoxFit.cover,
                                gaplessPlayback: true,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
