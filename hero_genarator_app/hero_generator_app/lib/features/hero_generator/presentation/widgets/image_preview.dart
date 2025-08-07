import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String imageUrl;
  const ImagePreview({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl, height: 200, fit: BoxFit.cover);
  }
}
