// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product2Model {
  int? id;
  String? title;
  String? description;
  num? price;
  String? image;
  int? categoryId;

  Product2Model({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
  });
  factory Product2Model.fromJson(Map<String, dynamic> json) {
    return Product2Model(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      categoryId: json['category_id'],
    );
  }
}
