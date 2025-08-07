import 'package:flutter/material.dart';
import 'package:hero_generator_app/features/hero_generator/domain/entities/hero_entity.dart';

class HeroDetailPage extends StatelessWidget {
  final HeroEntity hero;
  const HeroDetailPage({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hero.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(hero.image),
          const SizedBox(height: 16),
          Text(hero.universe, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
