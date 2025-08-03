// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:chat_app_flutter/models/message_model.dart';

class ChatModel {
  final String senderId;
  final String senderName;
  final String recieverId;
  final String recieverName;
  final MessageModel message;

  ChatModel({
    required this.senderId,
    required this.senderName,
    required this.recieverId,
    required this.recieverName,
    required this.message,
  });

  ChatModel copyWith({
    String? senderId,
    String? senderName,
    String? recieverId,
    String? recieverName,
    MessageModel? message,
  }) {
    return ChatModel(
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      recieverId: recieverId ?? this.recieverId,
      recieverName: recieverName ?? this.recieverName,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderName': senderName,
      'recieverId': recieverId,
      'recieverName': recieverName,
      'message': message.toMap(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      senderId: map['senderId'] as String,
      senderName: map['senderName'] as String,
      recieverId: map['recieverId'] as String,
      recieverName: map['recieverName'] as String,
      message: MessageModel.fromMap(map['message'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(senderId: $senderId, senderName: $senderName, recieverId: $recieverId, recieverName: $recieverName, message: $message)';
  }
}
