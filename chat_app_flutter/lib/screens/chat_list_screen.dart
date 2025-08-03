// import 'package:chat_app_flutter/screens/chat_screen.dart';
// import 'package:chat_app_flutter/screens/profile_edit_screen.dart';
// import 'package:chat_app_flutter/viewmodel/users_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ChatListScreen extends StatelessWidget {
//   const ChatListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//             },
//             icon: Icon(Icons.logout),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//           children: [
//             Text(
//               "Profile",
//               style: Theme.of(
//                 context,
//               ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             InkWell(
//               onTap: () async {
//                 await context.read<UsersProvider>().getUser(
//                   FirebaseAuth.instance.currentUser!.uid,
//                 );
//                 if (!context.mounted) return;
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => EditUserScreen()),
//                 );
//               },
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(
//                   "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg",
//                   scale: 1,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: StreamBuilder(
//         stream: context.read<UsersProvider>().getUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator.adaptive());
//           } else if (snapshot.hasError) {
//             return Center(child: Text(snapshot.error.toString()));
//           } else if (snapshot.data?.docs == null) {
//             return Center(child: Text("no users"));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final userData = snapshot.data!.docs[index];
//               return userData["email"] ==
//                       FirebaseAuth.instance.currentUser?.email
//                   ? SizedBox.shrink()
//                   : ListTile(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ChatScreen(
//                               otherUserID: userData['id'],
//                               otherUserName: userData["name"],
//                               otherUserAvatarUrl: userData['imageUrl'],
//                             ),
//                           ),
//                         );
//                       },
//                       leading: CircleAvatar(
//                         radius: 60,
//                         backgroundImage: userData['imageUrl'] != null
//                             ? FileImage(userData['imageUrl'])
//                             : AssetImage("asstes/images/placeholder.png"),
//                       ),
//                       title: Text(userData['name']),
//                     );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:chat_app_flutter/screens/profile_edit_screen.dart';
import 'package:chat_app_flutter/viewmodel/chat_auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart'; // chat screen alohida fayl bo‘lsa

class ImageListScreen extends StatelessWidget {
  const ImageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Foydalanuvchilar'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final rawData = snapshot.data!.data();
                if (rawData == null || rawData is! Map<String, dynamic>) {
                  return const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Center(child: Text("Ma'lumot topilmadi")),
                  );
                }

                final userData = rawData as Map<String, dynamic>;
                final imageUrl =
                    userData['image'] ??
                    'https://academy.rudn.ru/static/images/profile_default.png';
                final name = userData['name'] ?? 'Foydalanuvchi';
                final email = userData['email'] ?? currentUser!.email ?? '';

                return UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.blue),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  accountName: Text(name),
                  accountEmail: Text(email),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Profilni tahrirlash'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEditScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Chiqish'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Foydalanuvchilar yoq'));
          }

          final users = snapshot.data!.docs
              .where((doc) => doc.id != currentUser?.uid)
              .toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index].data() as Map<String, dynamic>;
              final userId = users[index].id;
              final name = userData['name'] ?? 'Nomaʼlum';
              final imageUrl = userData.containsKey('image')
                  ? userData['image']
                  : null;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: imageUrl != null
                      ? NetworkImage(imageUrl)
                      : const AssetImage('assets/images/profile.png')
                            as ImageProvider,
                ),
                title: Text(name),
                onLongPress: () async {
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Foydalanuvchini o'chirish"),
                      content: Text(
                        "Haqiqatan ham ushbu foydalanuvchini o'chirmoqchimisiz?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: Text("Bekor qilish"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: Text("O'chirish"),
                        ),
                      ],
                    ),
                  );

                  if (shouldDelete == true) {
                    await ChatAuthProvider().deleteUser(userId);
                  }
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        otherUserID: userId,
                        otherUserName: name,
                        otherUserAvatarUrl: imageUrl,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
