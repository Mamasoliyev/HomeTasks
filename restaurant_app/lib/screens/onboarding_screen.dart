import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/screens/request_screen.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  static String path = "/onboarding";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  int selectedPage = 0;

  List<Map<String, dynamic>> onboardingItems = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    initFirebaseAndData();
  }

  Future<void> initFirebaseAndData() async {
    await Firebase.initializeApp();

    onboardingItems = await fetchOnboardingData();

    setState(() {
      isLoading = false;
    });
  }

  Future<List<Map<String, dynamic>>> fetchOnboardingData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('onboarding')
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingItems.length,
                onPageChanged: (index) {
                  setState(() {
                    selectedPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = onboardingItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: SvgPicture.network(
                            item['imageUrl'],
                            placeholderBuilder: (context) => SizedBox(
                              height: 30,
                              width: 30,
                              child: Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          item['subtitle'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      context.push(RequestScreen.path);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      onboardingItems.length,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedPage == index
                              ? Colors.green
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    style: IconButton.styleFrom(minimumSize: Size(62, 30)),
                    onPressed: () {
                      if (selectedPage == onboardingItems.length - 1) {
                        context.push(RequestScreen.path);
                      } else {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.ease,
                        );
                      }
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
