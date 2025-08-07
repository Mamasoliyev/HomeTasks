import 'package:flutter/material.dart';
import 'package:hero_generator_app/features/hero_generator/domain/entities/hero_entity.dart';

class HeroCard extends StatelessWidget {
  final HeroEntity hero;
  const HeroCard({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(
          hero.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(hero.name),
        subtitle: Text(hero.universe),
      ),
    );
  }
}
