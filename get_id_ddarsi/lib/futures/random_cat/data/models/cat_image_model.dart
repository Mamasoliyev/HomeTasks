
import 'package:get_id_ddarsi/futures/random_cat/domain/entities/cat_image_entity';

class CatImageModel extends CatImage {
  CatImageModel({required super.url});

  factory CatImageModel.fromJson(Map<String, dynamic> json) {
    return CatImageModel(url: json['url']);
  }
}
