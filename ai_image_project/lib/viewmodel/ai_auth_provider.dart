import 'package:ai_image_project/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AiAuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String errorMessage = "";

  AuthService authService = AuthService();

  // REGISTER
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    isLoading = true;
    errorMessage = "";
    notifyListeners();
    try {
      final result = await authService.register(
        name: name,
        email: email,
        password: password,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // LOGIN
  Future<void> login({required String email, required String password}) async {
    isLoading = true;
    errorMessage = "";
    notifyListeners();
    try {
      final result = await authService.login(email: email, password: password);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // LOGOUT
  Future<void> logOut() async {
    FirebaseAuth.instance.signOut();
  }
}
