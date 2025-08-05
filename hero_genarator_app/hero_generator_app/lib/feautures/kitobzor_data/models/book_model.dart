import 'dart:convert';

class BookModel {
  final int? id;
  final bool? isUsed;
  final String? name;
  final String? author;
  final String? price;
  final String? discountPrice;
  final String? picture;
  final PostedBy? postedBy;
  final Shop? shop;
  final String? ownerType;
  final int? percentage;
  final int? likeCount;
  final int? viewCount;
  final DateTime? createdAt;

  BookModel({
    this.id,
    this.isUsed,
    this.name,
    this.author,
    this.price,
    this.discountPrice,
    this.picture,
    this.postedBy,
    this.shop,
    this.ownerType,
    this.percentage,
    this.likeCount,
    this.viewCount,
    this.createdAt,
  });

  factory BookModel.fromRawJson(String str) =>
      BookModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    id: json["id"],
    isUsed: json["is_used"],
    name: json["name"],
    author: json["author"],
    price: json["price"],
    discountPrice: json["discount_price"],
    picture: json["picture"],
    postedBy: json["posted_by"] == null
        ? null
        : PostedBy.fromJson(json["posted_by"]),
    shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
    ownerType: json["owner_type"],
    percentage: json["percentage"],
    likeCount: json["like_count"],
    viewCount: json["view_count"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_used": isUsed,
    "name": name,
    "author": author,
    "price": price,
    "discount_price": discountPrice,
    "picture": picture,
    "posted_by": postedBy?.toJson(),
    "shop": shop?.toJson(),
    "owner_type": ownerType,
    "percentage": percentage,
    "like_count": likeCount,
    "view_count": viewCount,
    "created_at": createdAt?.toIso8601String(),
  };
}

class PostedBy {
  final int? id;
  final String? picture;
  final String? firstName;
  final String? lastName;

  PostedBy({this.id, this.picture, this.firstName, this.lastName});

  factory PostedBy.fromRawJson(String str) =>
      PostedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
    id: json["id"],
    picture: json["picture"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "picture": picture,
    "first_name": firstName,
    "last_name": lastName,
  };
}

class Shop {
  final int? id;
  final String? name;
  final String? picture;

  Shop({this.id, this.name, this.picture});

  factory Shop.fromRawJson(String str) => Shop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shop.fromJson(Map<String, dynamic> json) =>
      Shop(id: json["id"], name: json["name"], picture: json["picture"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "picture": picture};
}
