import '../../domain/entities/hero_entity.dart';

class HeroModel extends HeroEntity {
  HeroModel({
    required String id,
    required String name,
    required String universe,
    required String image,
  }) : super(id: id, name: name, universe: universe, image: image);

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      id: json['id'] as String,
      name: json['name'] as String,
      universe: json['universe'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'universe': universe, 'image': image};
  }
}
