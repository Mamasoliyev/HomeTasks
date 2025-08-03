import 'dart:developer';
import 'dart:io';

import 'package:ai_image_project/services/auth_service.dart';
import 'package:ai_image_project/services/image_generation_service.dart';
import 'package:ai_image_project/services/storage_service.dart';
import 'package:flutter/material.dart';

class AiImageProvider extends ChangeNotifier {
  final AuthService authService;
  final ImageGenerationService imageGenerationService;
  final StorageService storageService;

  AiImageProvider({
    required this.authService,
    required this.imageGenerationService,
    required this.storageService,
  });

  bool isLoading = false;
  String errorMessage = "";
  final TextEditingController textPrompt = TextEditingController();
  bool isNotEmpty = false;

  void setIsNotEmpty(bool isNotEmpty_) {
    isNotEmpty = isNotEmpty_;
    notifyListeners();
  }

  File? generatedImage;

  // ImageGenerationService imageGenerationService = ImageGenerationService();
  // StorageService storageService = StorageService();

  Future<void> generateImage() async {
    isLoading = true;
    errorMessage = "";
    notifyListeners();

    final prompt = textPrompt.text.trim();

    try {
      final image = await imageGenerationService.generateImage(prompt);
      generatedImage = image;

      final imageLink = await storageService.uploadImageToStorage(image!);
      log("ImageLink: $imageLink");
      log("Prompt: $prompt");

      await AuthService().saveImageToFirestore(imageLink, prompt);
    } catch (e) {
      errorMessage = e.toString();
      log("❌ Error: $e");
    } finally {
      textPrompt.clear();
      isLoading = false;
      notifyListeners();
    }
  }
}
