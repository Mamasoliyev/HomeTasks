import 'package:flutter/material.dart';
import 'package:xarita_map_ai/models/generation_model.dart';
import 'package:xarita_map_ai/services/get_service.dart';
import 'package:xarita_map_ai/services/image_service.dart';

class GenerationImageProvider with ChangeNotifier {
  final GPTService _getService = GPTService();
  final ImageService imageService = ImageService();

  bool isLoading = false;

  String? errorMessage = "";

  GenerationModel? generationModel;

  Future<void> generationContent(String userInput) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _getService.generatePoemAndPrompt(userInput);

      generationModel = GenerationModel.fromMap({
        userInput: userInput,
        'poem': result['poem'] ?? '',
        'imagePrompt': result['prompt'] ?? '',
      });

      final imageUrl = await imageService.generateImage(
        generationModel!.imagePrompt,
      );

      generationModel = GenerationModel(
        userInput: generationModel!.userInput,
        poem: generationModel!.poem,
        imagePrompt: imageUrl,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
