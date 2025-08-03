import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class ChatAuthProvider extends ChangeNotifier {
  bool isLoading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> saveUserToken(String userId) async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await firebaseFirestore.collection("users").doc(userId).update({
        "fcmToken": token,
      });
    }
  }

  Future<void> login({required String email, required String password}) async {
    isLoading = true;
    notifyListeners();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,

        password: password,
      );

      await firebaseAuth.currentUser?.updateDisplayName(name);
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid)
          .set({
            'name': name,
            'email': email,
            'image':
                'https://academy.rudn.ru/static/images/profile_default.png',
            'createdAt': FieldValue.serverTimestamp(),
            // boshqa kerakli maydonlar...
          });
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      debugPrint('User $userId successfully deleted!');
    } catch (e) {
      debugPrint('Failed to delete user: $e');
    }
  }


  
}

// const {onDocumentCreated} = require("firebase-functions/v2/firestore");
// const {initializeApp} = require("firebase-admin/app");
// const {getFirestore} = require("firebase-admin/firestore");
// const {getMessaging} = require("firebase-admin/messaging");

// initializeApp();

// exports.sendMessageNotification = onDocumentCreated(
//     "chat-messages/{chatId}/messages/{messageId}",
//     async (event) => {
//       if (!event.data) {
//         console.log("❗ No message snapshot");
//         return;
//       }

//       const message = event.data.data();
//       const senderId = message.senderId;
//       const receiverId = message.recieverId;

//       if (!senderId || !receiverId) {
//         console.log("❗ Missing senderId or receiverId");
//         return;
//       }

//       const db = getFirestore();

//       // ✅ Fetch sender name
//       let senderName = "Someone";
//       try {
//         const senderSnap = await db.collection("users").doc(senderId).get();
//         senderName = senderSnap.data()?.name || senderId;
//       } catch (e) {
//         console.error("❌ Failed to get sender name", e);
//       }

//       // ✅ Fetch receiver FCM token
//       const receiverSnap = await db.collection("users").doc(receiverId).get();
//       const fcmToken = receiverSnap.data()?.fcmToken;

//       if (!fcmToken) {
//         console.log(`❗ No FCM token for user: ${receiverId}`);
//         return;
//       }

//       const payload = {
//         notification: {
//           title: `New message from ${senderName}`,
//           body: message.body || "You have a new message!",
//         },
//         token: fcmToken,
//       };

//       try {
//         await getMessaging().send(payload);
//         console.log("✅ Notification sent to", receiverId);
//       } catch (err) {
//         console.error("❌ Failed to send notification", err);
//       }
//     },
// );
