import 'dart:convert';

class ShopBookModel {
  final int? id;
  final String? name;
  final String? picture;
  final String? star;
  final int? bookCount;

  ShopBookModel({this.id, this.name, this.picture, this.star, this.bookCount});

  factory ShopBookModel.fromRawJson(String str) =>
      ShopBookModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShopBookModel.fromJson(Map<String, dynamic> json) => ShopBookModel(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    star: json["star"],
    bookCount: json["book_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture": picture,
    "star": star,
    "book_count": bookCount,
  };
}
