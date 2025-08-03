import 'package:chat_app_flutter/models/chat_model.dart';
import 'package:chat_app_flutter/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  ChatService chatService = ChatService();

  Future<void> sendMessage(ChatModel chat) async {
    await chatService.sendMessage(chat);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage({
    required String senderId,
    required String recieverEmail,
  }) {
    return chatService.getMessages(
      senderId: senderId,
      reciverEmail: recieverEmail,
    );
  }
}
