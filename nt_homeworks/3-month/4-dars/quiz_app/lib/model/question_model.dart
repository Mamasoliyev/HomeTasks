class QuestionModel {
  final String? name;
  final num? price;
  final String? description;
  final num? averageRating;
  final String? deliveryPrice;
  final String? deliveryTime;
  final String? size;
  final List<String?>? ingredients;
  QuestionModel({
    required this.name,
    required this.price,
    required this.description,
    required this.averageRating,
    required this.deliveryPrice,
    required this.deliveryTime,
    required this.size,
    required this.ingredients,
  });


  // factory QuestionModel.fromJson(Map<String, dynamic> json) {
  //   return QuestionModel.fromJson(
    
  //   );
  // }

}