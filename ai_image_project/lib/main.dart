import 'package:ai_image_project/firebase_options.dart';
import 'package:ai_image_project/screens/auth_screen.dart';
import 'package:ai_image_project/screens/home_screen.dart';
import 'package:ai_image_project/services/auth_service.dart';
import 'package:ai_image_project/services/image_generation_service.dart';
import 'package:ai_image_project/services/storage_service.dart';
import 'package:ai_image_project/viewmodel/ai_auth_provider.dart';
import 'package:ai_image_project/viewmodel/ai_image_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AiAuthProvider()),
        ChangeNotifierProvider(
          create: (_) => AiImageProvider(
            authService: AuthService(),
            imageGenerationService: ImageGenerationService(),
            storageService: StorageService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    ),
  );
}
