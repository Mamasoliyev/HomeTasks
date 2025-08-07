import '../entities/image_entity.dart';

abstract class ImageRepository {
  Future<ImageEntity> generateImage(String prompt);
}
