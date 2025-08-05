class CategoryModel {
  final int id;
  final String name;
  final String picture;

  CategoryModel({required this.id, required this.name, required this.picture});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
    );
  }
}
