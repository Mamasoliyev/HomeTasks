import 'dart:developer';

import 'package:chat_app_flutter/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(ChatModel chatModel) async {
    try {
      final docList = [chatModel.recieverId, chatModel.senderId];

      docList.sort();
      final chatId = docList.join("-");

      final chatRef =await firebaseFirestore
          .collection("chat-messages")
          .doc(chatId)
          .collection("messages")
          .add(chatModel.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String senderId,
    required String reciverEmail,
  }) {
    final docList = [reciverEmail, senderId];

    docList.sort();
    final chatId = docList.join("-");

    return firebaseFirestore
        .collection("chat-messages")
        .doc(chatId)
        .collection("messages")
        .orderBy("message.timestamp", descending: false)
        .snapshots();
  }
}
