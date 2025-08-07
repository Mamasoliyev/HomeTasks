import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_generator_app/features/hero_generator/data/repositories/image_repository_impl.dart';
import 'package:hero_generator_app/features/hero_generator/domain/entities/hero_entity.dart';
import 'package:hero_generator_app/features/hero_generator/domain/repositories/image_repository.dart';
import 'package:hero_generator_app/features/hero_generator/domain/usecases/generate_image.dart';
import 'package:hero_generator_app/features/hero_generator/presentation/bloc/hero/hero_bloc.dart';
import 'package:hero_generator_app/features/hero_generator/presentation/bloc/hero/hero_event.dart';
import 'package:hero_generator_app/features/hero_generator/presentation/bloc/image/image_bloc.dart';
import 'package:hero_generator_app/features/hero_generator/presentation/bloc/image/image_event.dart';

class HeroFormPage extends StatelessWidget {
  const HeroFormPage({super.key});


  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final universeController = TextEditingController();
    final imageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Hero')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: universeController,
              decoration: const InputDecoration(labelText: 'Universe'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image Prompt'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Dispatch CreateHeroEvent
                final name = nameController.text;
                final universe = universeController.text;
                final image = imageController.text;
                if (name.isNotEmpty &&
                    universe.isNotEmpty &&
                    image.isNotEmpty) {
                  BlocProvider.of<HeroBloc>(context).add(
                    CreateHeroEvent(
                      HeroEntity(
                        id: '123',
                        name: name,
                        universe: universe,
                        image: image,
                      ),
                    ),
                  );
                  BlocProvider.of<ImageBloc>(context).add(
                    GenerateImageEvent(image),
                  );
                  Navigator.pop(context); // Go back after saving
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
