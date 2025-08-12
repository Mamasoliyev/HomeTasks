import 'package:ai_book_summary_app/features/auth/presintitation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int selctetPage = 0;

  List images = [
    Image.asset("asstes/images/onb1.jpg"),
    Image.asset("asstes/images/onb2.jpg"),
    Image.asset("asstes/images/onb3.jpg"),
  ];

  List<String> titles = [
    "Now reading books\nwill be easier",
    "Your Bookish Soulmate\nAwaits",
    "Start Your Adventure\n  ",
  ];

  List<String> content = [
    " Discover new worlds, join a vibrant\nreading community. Start your reading\nadventure effortlessly with us.",
    "Let us be your guide to the perfect read.\nDiscover books tailored to your tastes\nfor a truly rewarding experience.",
    "Ready to embark on a quest for inspiration\nand knowledge? Your adventure begins\nnow. Let's go!",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    selctetPage = value;
                  });
                },
                itemCount: 3,
                itemBuilder: (context, index) => Column(
                  spacing: 15,
                  children: [
                    images[index],
                    Text(
                      textAlign: TextAlign.center,
                      titles[index],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      textAlign: TextAlign.center,
                      content[index],
                      style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  width: index == selctetPage ? 15 : 10,
                  height: index == selctetPage ? 15 : 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: index == selctetPage ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                  elevation: 0,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                  if (selctetPage == 2) {
                    Get.to(LoginScreen());
                  }
                },
                child: Text("Get Started", style: TextStyle(fontSize: 17)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                onPressed: () {
                  Get.to(LoginScreen());
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
