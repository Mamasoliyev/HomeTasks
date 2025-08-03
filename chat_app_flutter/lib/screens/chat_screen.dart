import 'package:chat_app_flutter/models/chat_model.dart';
import 'package:chat_app_flutter/models/message_model.dart';
import 'package:chat_app_flutter/services/url_launchers.dart';
import 'package:chat_app_flutter/viewmodel/chat_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String otherUserName;
  final String otherUserAvatarUrl;
  final String otherUserID;

  const ChatScreen({
    super.key,
    required this.otherUserName,
    required this.otherUserAvatarUrl,
    required this.otherUserID,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.otherUserAvatarUrl),
          ),
        ),
        title: Text(
          widget.otherUserName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () async {
              await phoneLauncher("+998990375006");
            }, // optional call action
          ),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Messages List
            StreamBuilder(
              stream: context.read<ChatProvider>().getMessage(
                senderId: FirebaseAuth.instance.currentUser!.uid,
                recieverEmail: widget.otherUserID,
              ),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (asyncSnapshot.hasError) {
                  return Center(child: Text(asyncSnapshot.error.toString()));
                } else if (!asyncSnapshot.hasData) {
                  return Center(child: Text("no chat"));
                }
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    reverse: true,
                    itemCount: asyncSnapshot.data!.docs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, idx) {
                      final msg = asyncSnapshot
                          .data!
                          .docs[asyncSnapshot.data!.docs.length - 1 - idx];
                      final isMe =
                          FirebaseAuth.instance.currentUser!.uid ==
                          msg['senderId'];
                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.8)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(isMe ? 16 : 4),
                              bottomRight: Radius.circular(isMe ? 4 : 16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Text(
                            msg['message']['title']!.toString(),
                            style: TextStyle(
                              color: isMe
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            // Input area
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: 4),
                  FloatingActionButton.small(
                    onPressed: () async {
                      await context.read<ChatProvider>().sendMessage(
                        ChatModel(
                          senderId: FirebaseAuth.instance.currentUser!.uid,
                          senderName: FirebaseAuth
                              .instance
                              .currentUser!
                              .displayName
                              .toString(),
                          recieverId: widget.otherUserID,
                          recieverName: widget.otherUserName,
                          message: MessageModel(
                            title: textController.text.toString(),
                            body: "Hey",
                            timestamp: DateTime.now(),
                          ),
                        ),
                      );
                      textController.clear();
                    },
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
