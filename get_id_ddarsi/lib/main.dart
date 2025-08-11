import 'package:flutter/material.dart';
import 'package:get_id_ddarsi/futures/random_cat/presintation/provider/cat_imagr_provider.dart';
import 'package:get_id_ddarsi/futures/random_cat/presintation/screens/cat_image_screen.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<CatImageProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CatImagePage(),
      ),
    );
  }
}
