import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_generator_app/features/hero_generator/presentation/pages/hero_form_page.dart';
import '../bloc/hero/hero_bloc.dart';
import '../bloc/hero/hero_state.dart';
import '../widgets/hero_card.dart';

class HeroListPage extends StatelessWidget {
  const HeroListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heroes'), centerTitle: true),
      body: BlocBuilder<HeroBloc, HeroState>(
        builder: (context, state) {
          if (state is HeroLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HeroLoaded) {
            return ListView.builder(
              itemCount: state.heroes.length,
              itemBuilder: (context, index) {
                final hero = state.heroes[index];
                return HeroCard(hero: hero);
              },
            );
          } else if (state is HeroError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No heroes found.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to form page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HeroFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
