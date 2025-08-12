import 'package:ai_book_summary_app/core/app/di/injection_auth_container.dart';
import 'package:ai_book_summary_app/core/app/di/injection_container.dart'
    hide locator;
import 'package:ai_book_summary_app/features/auth/domain/uscases/register_user.dart';
import 'package:ai_book_summary_app/features/auth/presintitation/controller/auht_controller.dart';
import 'package:ai_book_summary_app/features/book/presentation/screens/history_screen.dart';
import 'package:ai_book_summary_app/features/book/presentation/screens/splash_scree.dart';
import 'package:ai_book_summary_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initDI();
  await init();
  await GetStorage.init();

  final registerUser = locator<RegisterUser>();
  Get.put(AuthController(registerUser));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.robotoTextTheme().displayMedium!.fontFamily,
      ),
      getPages: [GetPage(name: "/history", page: () => HistoryScreen())],
      home: SplashScreen(),
    );
  }
}
