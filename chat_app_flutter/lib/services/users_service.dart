import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class UsersService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    final users = firebaseFirestore.collection("users").snapshots();
    return users;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) async {
    return await firebaseFirestore.collection("users").doc(uid).get();
  }
}
