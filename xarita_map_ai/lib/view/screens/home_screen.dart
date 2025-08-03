import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xarita_map_ai/view_model/generation_image_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Consumer<GenerationImageProvider>(
        builder: (context, provider, child) {
          // if (provider.isLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          // if (provider.errorMessage != null ||
          //     provider.errorMessage!.isNotEmpty) {
          //   return Center(
          //     child: Text(
          //       'Error: ${provider.errorMessage}',
          //       style: const TextStyle(color: Colors.red),
          //     ),
          //   );
          // }

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextField(
                  onSubmitted: (value) => provider.generationContent(value),
                  decoration: InputDecoration(labelText: 'Matn kiriting'),
                ),
                if (provider.generationModel != null) ...[
                  Text('She\'r:\n${provider.generationModel!.poem}'),
                  Text(
                    'Image Prompt:\n${provider.generationModel!.imagePrompt}',
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final imageUrl = await provider.imageService
                          .generateImage(provider.generationModel!.imagePrompt);
                      log('Rasm URL: $imageUrl');
                    },
                    child: Text('Rasm generatsiya qilish'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
