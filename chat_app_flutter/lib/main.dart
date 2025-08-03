import 'package:chat_app_flutter/firebase_options.dart';
import 'package:chat_app_flutter/screens/auth_screen.dart';
import 'package:chat_app_flutter/screens/chat_list_screen.dart';
import 'package:chat_app_flutter/services/notification_service.dart';
import 'package:chat_app_flutter/viewmodel/chat_auth_provider.dart';
import 'package:chat_app_flutter/viewmodel/chat_provider.dart';
import 'package:chat_app_flutter/viewmodel/users_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService().initNotification();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatAuthProvider()),
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ImageListScreen();
            }
            return ImageListScreen();
          },
        ),
      ),
    );
  }
}
