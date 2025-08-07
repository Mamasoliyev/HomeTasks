import '../entities/image_entity.dart';
import '../repositories/image_repository.dart';

class GenerateImage {
  final ImageRepository repository;
  GenerateImage(this.repository);

  Future<ImageEntity> call(String prompt) => repository.generateImage(prompt);
}
