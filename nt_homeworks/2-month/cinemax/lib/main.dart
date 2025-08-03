import 'package:cinemax/screens/actor_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(CinemaxApp());
}

class CinemaxApp extends StatelessWidget {
  CinemaxApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ActorScreen());
  }
}
