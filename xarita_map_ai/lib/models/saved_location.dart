class SavedLocation {
  final double lat;
  final double lng;

  SavedLocation({required this.lat, required this.lng});

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};

  factory SavedLocation.fromJson(Map<String, dynamic> json) {
    return SavedLocation(lat: json['lat'], lng: json['lng']);
  }
}
