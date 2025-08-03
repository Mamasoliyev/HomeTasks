import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(userCredential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains("email address is badly")) {
        throw Exception("Please enter valid email address.");
      } else if (e.message!.contains("6 characters")) {
        throw Exception(e.message);
      } else if (e.message!.contains("use by another account")) {
        throw Exception(e.message);
      }

      log(e.toString());
      throw Exception(e.message);
    } catch (e) {
      log(e.toString());
    }
  }

  // SIGN IN
  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(userCredential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains("credential is malformed")) {
        throw Exception("Given credentials are incorrect");
      }
      log(e.message.toString());
      throw Exception(e.message);
    } catch (e) {
      log(e.toString());
    }
  }

  // LOG OUT
  Future<void> logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      throw Exception("Error while logging out");
    }
  }
}
