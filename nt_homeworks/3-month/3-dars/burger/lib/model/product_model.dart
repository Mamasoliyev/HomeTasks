class ProductModel {
  final String? name;
  final num? price;
  final String? description;
  final num? averageRating;
  final String? deliveryPrice;
  final String? deliveryTime;
  final String? size;
  final List<String?>? ingredients;

  ProductModel({
    required this.name,
    required this.price,
    required this.description,
    required this.averageRating,
    required this.deliveryPrice,
    required this.deliveryTime,
    required this.size,
    required this.ingredients,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: json['price'],
      description: json['description'],
      averageRating: json['average_rating'],
      deliveryPrice: json['delivery_price'],
      deliveryTime: json['delivery_time'],
      size: json['size'],
      ingredients:List<String>.from(json['ingredients']),
    );
  }
  @override
  String toString() {
    return 'ProductModel(name: $name, price: $price, rating: $averageRating)';
      }
}