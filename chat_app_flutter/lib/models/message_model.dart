// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  final String title;
  final String body;
  final DateTime timestamp;

  MessageModel({
    required this.title,
    required this.body,
    required this.timestamp,
  });

  MessageModel copyWith({
    String? title,
    String? body,
    DateTime? timestamp,
  }) {
    return MessageModel(
      title: title ?? this.title,
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      title: map['title'] as String,
      body: map['body'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessageModel(title: $title, body: $body, timestamp: $timestamp)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.body == body &&
      other.timestamp == timestamp;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode ^ timestamp.hashCode;
}
