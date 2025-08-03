import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xarita_map_ai/services/Poem_provider.dart';
import 'package:xarita_map_ai/services/get_service.dart';
import 'package:xarita_map_ai/services/image_service.dart';
import 'package:xarita_map_ai/view/screens/home_screen.dart';
import 'package:xarita_map_ai/view/screens/map_screen.dart';
import 'package:xarita_map_ai/view/screens/poem_screen.dart';

import 'package:xarita_map_ai/view_model/generation_image_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => PoemProvider(GPTService(), ImageService()),
    ),
    ChangeNotifierProvider(
      create: (context) => GenerationImageProvider(),
    ),
  ], child: MyApp()));
}

const String googleApiKey = 'AIzaSyB_frTQZpLcjRODMaCXv83J6In-k02OO4s';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MapScreen());
  }
}
