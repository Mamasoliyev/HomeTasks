// import 'package:ai_book_summary_app/features/auth/presintitation/screens/register_screen.dart';
// import 'package:ai_book_summary_app/features/book/presentation/screens/book_summary_screen.dart';
// import 'package:ai_book_summary_app/features/book/presentation/screens/onboarding_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:async';

// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/route_manager.dart'; // Timer uchun

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat();

//     Timer(const Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => OnboardingScreen()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Row(
//           spacing: 6,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RotationTransition(
//               turns: _controller,
//               child: const Center(
//                 child: Icon(
//                   Icons.panorama_horizontal_select_outlined,
//                   size: 40,
//                   color: Colors.white,
//                 ),
//               ),
//             ),

//             Text(
//               "Sphere",
//               style: TextStyle(
//                 fontSize: 33,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:ai_book_summary_app/features/auth/presintitation/screens/register_screen.dart';
import 'package:ai_book_summary_app/features/book/presentation/screens/book_summary_screen.dart';
import 'package:ai_book_summary_app/features/book/presentation/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // 5 soniyadan keyin autentifikatsiyani tekshirib navigatsiya qilish
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        // Foydalanuvchi autentifikatsiya qilinganligini tekshirish
        final user = _auth.currentUser;
        if (user != null) {
          // Foydalanuvchi login qilgan bo‘lsa, SummaryScreen’ga o‘tish
          Get.offAll(() => SummaryScreen());
        } else {
          // Aks holda, OnboardingScreen’ga o‘tish
          Get.offAll(() => SummaryScreen());
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: const Icon(
                Icons.panorama_horizontal_select_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              "Sphere",
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
