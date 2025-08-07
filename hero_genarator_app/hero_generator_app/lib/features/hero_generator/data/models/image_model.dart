import '../../domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  ImageModel({required String url}) : super(url);

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(url: json['url'] ?? '');
  }
}
