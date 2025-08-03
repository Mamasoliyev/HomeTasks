import 'package:ecommerce_app/service/cache_helper.dart';
import 'package:ecommerce_app/view/screens/animate_screen.dart';
import 'package:ecommerce_app/view/screens/custom_painters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:ecommerce_app/view/screens/home_screen.dart';
import 'package:ecommerce_app/view/screens/onboarding_screen.dart';
import 'package:ecommerce_app/view/screens/log_in_screen.dart';
import 'package:ecommerce_app/view/screens/splash_screen.dart';
import 'package:ecommerce_app/view/screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  await CacheHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'custom',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'splash':
            return CupertinoPageRoute(
              builder: (context) => const SplashScreen(),
            );
          case 'log_in':
            return CupertinoPageRoute(
              builder: (context) => const LogInScreen(),
            );
          case 'sign_up':
            return CupertinoPageRoute(
              builder: (context) => const SignUpScreen(),
            );
          case 'onboarding':
            return CupertinoPageRoute(
              builder: (context) => const OnboardingScreen(),
            );
            case 'home':
            return CupertinoPageRoute(builder: (context) => const HomeScreen());
          case 'custom':
            return CupertinoPageRoute(builder: (context) => const CustomPainters());
          case 'animate':
            return CupertinoPageRoute(builder: (context) => const Animatsiyalar());  
          default:
            return CupertinoPageRoute(
              builder: (context) => const SplashScreen(),
            );
        }
      },
      onUnknownRoute: (settings) =>
          CupertinoPageRoute(builder: (context) => const SignUpScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
