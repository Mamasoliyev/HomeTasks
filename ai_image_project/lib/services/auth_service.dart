import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final ref = firebaseFirestore.collection("users");
      ref.doc(firebaseAuth.currentUser?.uid).set({
        "name": name,
        "email": email,
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  //imageni gallareyaga saqlash yana firestorega
  // Future<void> saveImageToFirestore(String imageUrl, String promt) async {
  //   final user = firebaseAuth.currentUser;

  //   if (user == null) return;

  //   await firebaseFirestore
  //       .collection('users')
  //       .doc(user.uid)
  //       .collection('images')
  //       .add({
  //         'imageUrl': imageUrl,
  //         'promt': promt,
  //         'createdAt': FieldValue.serverTimestamp(),
  //       });
  // }

  Future<void> saveImageToFirestore(String imageUrl, String promt) async {
    final user = firebaseAuth.currentUser;

    if (user == null) return;

    try {
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('images')
          .add({
            'imageUrl': imageUrl,
            'promt': promt,
            'createdAt': FieldValue.serverTimestamp(),
          });
      log("✅ Rasm Firestore'ga saqlandi: $imageUrl");
    } catch (e) {
      log("❌ Firestore'ga yozishda xato: $e");
    }
  }

  Stream<List<Map<String, dynamic>>> getUserImages() {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .collection('images')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            data['docId'] = doc.id;
            return data;
          }).toList(),
        );
  }
}
