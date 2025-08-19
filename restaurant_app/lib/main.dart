import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/firebase_options.dart';
import 'package:food_app/providers/book_provider.dart';
import 'package:food_app/providers/resturant_provider.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/all_fooods_screen.dart';
import 'package:food_app/screens/book_screen.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/map_screen.dart';
import 'package:food_app/screens/navigation_screen.dart';
import 'package:food_app/screens/onboarding_screen.dart';
import 'package:food_app/screens/profile_screen.dart';
import 'package:food_app/screens/request_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => RestaurantProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: OnboardingScreen.path,
    routes: [
      GoRoute(
        path: OnboardingScreen.path,
        builder: (context, state) => const OnboardingScreen(),
        redirect: (context, state) {
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            return OnboardingScreen .path;
          } else {
            return MainNavigation.path;
          }
        },
      ),

      GoRoute(
        path: RequestScreen.path,
        builder: (context, state) => const RequestScreen(),
      ),

      GoRoute(
        path: MainNavigation.path,
        builder: (context, state) => const MainNavigation(),
      ),

      GoRoute(
        path: AllFoodsScreen.path,
        builder: (context, state) =>
            AllFoodsScreen(location: state.extra as String),
      ),
      GoRoute(
        path: SearchScreen.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SearchScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
