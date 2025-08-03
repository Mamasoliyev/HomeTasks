import 'package:flutter/foundation.dart';
import 'package:xarita_map_ai/models/poem_response.dart';
import 'package:xarita_map_ai/services/get_service.dart';
import 'package:xarita_map_ai/services/image_service.dart';



class PoemProvider with ChangeNotifier {
  final GPTService _gptService;
  final ImageService _imageService;

  PoemResponse? _poemResponse;
  String? _imageUrl;
  bool _isLoading = false;
  String? _error;

  PoemProvider(this._gptService, this._imageService);

  PoemResponse? get poemResponse => _poemResponse;
  String? get imageUrl => _imageUrl;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> generatePoemAndImage(String userInput) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // She’r va image promptni generatsiya qilish
      final poemData = await _gptService.generatePoemAndPrompt(userInput);
      _poemResponse = PoemResponse.fromJson(poemData);

      // Image prompt asosida rasm generatsiya qilish
      if (_poemResponse!.imagePrompt.isNotEmpty) {
        _imageUrl = await _imageService.generateImage(_poemResponse!.imagePrompt);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  void clear() {
    _poemResponse = null;
    _imageUrl = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}