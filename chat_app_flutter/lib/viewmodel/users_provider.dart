// import 'dart:developer';
// import 'dart:io';

// import 'package:chat_app_flutter/services/users_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';

// class UsersProvider extends ChangeNotifier {
//   bool isLoading = false;
//   Map<String, dynamic> user = {};

//   UsersService usersService = UsersService();

//   Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
//     return usersService.getUsers();
//   }

//   Future<void> getUser(String uid) async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final value = await usersService.getUser(uid);
//       final userData = value.data();

//       if (userData != null) {
//         user = {
//           'uid': value.id,
//           ...userData,
//         };
//       } else {
//         log("value.data() = null");
//       }
//     } catch (e) {
//       log("getUser error: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> updateUserProfile({
//     File? image,
//     LocationData? location,
//     required String name,
//     required String email,
//   }) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       String? imageUrl;

//       // 🔹 Yangi rasm bo‘lsa, yuklash
//       if (image != null) {
//         final ref = FirebaseStorage.instance
//             .ref()
//             .child("user_images")
//             .child("${user['uid']}.jpg");

//         await ref.putFile(image);
//         imageUrl = await ref.getDownloadURL();
//       }

//       // 🔹 Yangilanadigan ma’lumotlar
//       final updateData = <String, dynamic>{'name': name, 'email': email};

//       if (imageUrl != null) {
//         updateData['image'] = imageUrl;
//       }

//       if (location != null) {
//         updateData['location'] = {
//           'lat': location.latitude,
//           'lng': location.longitude,
//         };
//       }

//       // 🔹 Firestore'da yangilash
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(user["uid"])
//           .update(updateData);

//       // 🔹 Local user map'ni yangilash
//       user['name'] = name;
//       user['email'] = email;
//       if (imageUrl != null) {
//         user['image'] = imageUrl;
//       }
//       if (location != null) {
//         user['location'] = {
//           'lat': location.latitude,
//           'lng': location.longitude,
//         };
//       }
//     } catch (e) {
//       log("updateUserProfile error: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class UsersProvider with ChangeNotifier {
  Map<String, dynamic> user = {};
  bool isLoading = false;

  Future<void> loadUserData(String uid) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      if (doc.exists) {
        user = doc.data()!;
        notifyListeners();
      }
    } catch (e) {
      log('loadUserData error: $e');
    }
  }

  Future<void> updateUserProfile({
    required String uid,
    File? image,
    LocationData? location,
    required String name,
    required String email,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      String? imageUrl;

      if (image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child("user_images")
            .child("$uid.jpg");

        await ref.putFile(image);
        imageUrl = await ref.getDownloadURL();
      }

      final updateData = <String, dynamic>{'name': name, 'email': email};

      if (imageUrl != null) {
        updateData['image'] = imageUrl;
      }

      if (location != null) {
        updateData['location'] = {
          'lat': location.latitude,
          'lng': location.longitude,
        };
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update(updateData);

      // Local update
      user['name'] = name;
      user['email'] = email;
      if (imageUrl != null) user['image'] = imageUrl;
      if (location != null) {
        user['location'] = {
          'lat': location.latitude,
          'lng': location.longitude,
        };
      }
    } catch (e) {
      log("updateUserProfile error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
