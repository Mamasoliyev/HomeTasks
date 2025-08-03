 import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_lesson/screens/semple_screen.dart';
import 'package:google_maps_lesson/services/location_service.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final position = await getCurrentLocation();
  
  runApp(MyApp(position: LatLng(position!.latitude, position.longitude)));
}

class MyApp extends StatelessWidget {
  final LatLng position;
  const MyApp({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SempleScreen(location: position),
    );
  }
}
