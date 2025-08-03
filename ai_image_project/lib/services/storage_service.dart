import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadImageToStorage(File image) async {
    final imagesRef = storageRef.child("images");
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final childRef = imagesRef.child(fileName);

    try {
      await childRef.putFile(image);
      return await childRef.getDownloadURL();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteImage({
    required String docId,
    required String imageUrl,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final ref = firebaseStorage.refFromURL(imageUrl);
      await ref.delete();

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('images')
          .doc(docId)
          .delete();
    } catch (e) {
      log("ochirib bolmadi error --> $e");
    }
  }
}
