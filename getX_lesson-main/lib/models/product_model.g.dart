// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  slug: json['slug'] as String,
  price: (json['price'] as num).toInt(),
  description: json['description'] as String,
  category: Category.fromJson(json['category'] as Map<String, dynamic>),
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  creationAt: DateTime.parse(json['creationAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'images': instance.images,
      'creationAt': instance.creationAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: (json['id'] as num).toInt(),
  name: $enumDecode(_$NameEnumMap, json['name']),
  slug: $enumDecode(_$SlugEnumMap, json['slug']),
  image: json['image'] as String,
  creationAt: DateTime.parse(json['creationAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': _$NameEnumMap[instance.name]!,
  'slug': _$SlugEnumMap[instance.slug]!,
  'image': instance.image,
  'creationAt': instance.creationAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$NameEnumMap = {
  Name.CLOTHES: 'Clothes',
  Name.ELECTRONICS: 'Electronics',
  Name.FURNITURE: 'Furniture',
  Name.MISCELLANEOUS: 'Miscellaneous',
  Name.SHOES: 'Shoes',
};

const _$SlugEnumMap = {
  Slug.CLOTHES: 'clothes',
  Slug.ELECTRONICS: 'electronics',
  Slug.FURNITURE: 'furniture',
  Slug.MISCELLANEOUS: 'miscellaneous',
  Slug.SHOES: 'shoes',
};
