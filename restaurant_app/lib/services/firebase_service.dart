import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseService instance = FirebaseService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log('Sign In error: ${e.message}');
      throw Exception(e.message);
    }
  }

  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required dynamic fullname,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        'fullName': fullname,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log('Sign Up error: ${e.message}');
      throw Exception(e.message);
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      log('No user is signed in');
      return null;
    }

    log('Current UID: ${user.uid}');

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        log('User profile found: ${doc.data()}');
        return doc.data();
      } else {
        log('No document found for this UID in Firestore');
        return null;
      }
    } catch (e) {
      log('Get User Profile error: $e');
      return null;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}
