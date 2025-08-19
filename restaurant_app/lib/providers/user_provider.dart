import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/navigation_screen.dart';
import 'package:food_app/screens/onboarding_screen.dart';
import 'package:food_app/services/firebase_service.dart';
import 'package:go_router/go_router.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;
  String error = "";
  String signInError = "";

  bool _isRegistered = false; // qo'shamiz
  bool get isRegistered => _isRegistered;

  final service = FirebaseService.instance;

  // sign in
  Future<void> signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    error = "";
    isLoading = true;
    notifyListeners();
    try {
      await service.signIn(email: email, password: password);
      _isRegistered = true; // Kirganda ro'yxatdan o'tgan hisoblanadi
      context.go(MainNavigation.path);
      notifyListeners();
    } catch (e) {
      if (e is FirebaseException) {
        signInError = e.message ?? "Unknown error";
      } else {
        signInError = e.toString();
      }
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // sign up
  Future<void> signUp(
    BuildContext context, {
    required String fullName,
    required String email,
    required String password,
  }) async {
    error = "";
    isLoading = true;
    notifyListeners();
    try {
      await service.signUp(
        email: email,
        password: password,
        fullname: fullName,
      );
      _isRegistered = true; // Ro'yxatdan o'tgandan keyin flag true qilamiz
      notifyListeners();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(
          MainNavigation.path,
        ); // ro'yxatdan o'tgandan keyin home ga o'tamiz
      });
    } catch (e) {
      if (e is FirebaseException) {
        error = e.message ?? "Unknown error";
      } else {
        error = e.toString();
      }
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // logout
  Future<void> logOut(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await service.logOut();
    _isRegistered = false; // Chiqib ketganda false qilamiz

    isLoading = false;
    notifyListeners();

    context.go(OnboardingScreen.path);
    notifyListeners();
  }
}
