class BannerModel {
  final int id;
  final String title;
  final String picture;

  BannerModel({
    required this.id,
    required this.title,
    required this.picture,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      picture: json['picture'] ?? '',
    );
  }
}
