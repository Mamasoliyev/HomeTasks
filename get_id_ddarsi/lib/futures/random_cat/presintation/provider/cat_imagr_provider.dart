import 'package:flutter/material.dart';
import 'package:get_id_ddarsi/core/uscases/get_random_cat_image..dart';
import 'package:get_id_ddarsi/futures/random_cat/domain/entities/cat_image_entity';

class CatImageProvider with ChangeNotifier {
  final GetRandomCatImage getRandomCatImage;

  CatImageProvider({required this.getRandomCatImage});

  CatImage? catImage;
  String? error;
  bool isLoading = false;

  Future<void> fetchImage() async {
    isLoading = true;
    notifyListeners();

    final result = await getRandomCatImage();

    result.fold(
      (failure) {
        error = "Xatolik yuz berdi";
        catImage = null;
      },
      (image) {
        error = null;
        catImage = image;
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
