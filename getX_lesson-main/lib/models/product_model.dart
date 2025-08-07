// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'product_model.g.dart';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class ProductModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "slug")
  String slug;
  @JsonKey(name: "price")
  int price;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "category")
  Category category;
  @JsonKey(name: "images")
  List<String> images;
  @JsonKey(name: "creationAt")
  DateTime creationAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  Name name;
  @JsonKey(name: "slug")
  Slug slug;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "creationAt")
  DateTime creationAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

enum Name {
  @JsonValue("Clothes")
  CLOTHES,
  @JsonValue("Electronics")
  ELECTRONICS,
  @JsonValue("Furniture")
  FURNITURE,
  @JsonValue("Miscellaneous")
  MISCELLANEOUS,
  @JsonValue("Shoes")
  SHOES
}

final nameValues = EnumValues({
  "Clothes": Name.CLOTHES,
  "Electronics": Name.ELECTRONICS,
  "Furniture": Name.FURNITURE,
  "Miscellaneous": Name.MISCELLANEOUS,
  "Shoes": Name.SHOES
});

enum Slug {
  @JsonValue("clothes")
  CLOTHES,
  @JsonValue("electronics")
  ELECTRONICS,
  @JsonValue("furniture")
  FURNITURE,
  @JsonValue("miscellaneous")
  MISCELLANEOUS,
  @JsonValue("shoes")
  SHOES
}

final slugValues = EnumValues({
  "clothes": Slug.CLOTHES,
  "electronics": Slug.ELECTRONICS,
  "furniture": Slug.FURNITURE,
  "miscellaneous": Slug.MISCELLANEOUS,
  "shoes": Slug.SHOES
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
