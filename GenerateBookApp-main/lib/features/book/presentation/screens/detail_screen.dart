import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String author;
  final String summary;
  final int rating;
  final String image;

  const DetailScreen({
    super.key,
    required this.title,
    required this.author,
    required this.summary,
    required this.image,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 181, 139, 139),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(title, style: TextStyle(fontSize: 19)),
        backgroundColor: const Color.fromARGB(255, 181, 139, 139),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: StarRating(value: rating, size: 24),
                  ),
                ],
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            if (author.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                author,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.purple),
              ),
              child: Text(summary, style: theme.textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int value; // 0..5
  final double size;
  final Color? color;

  const StarRating({
    super.key,
    required this.value,
    this.size = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final starColor = color ?? const Color.fromARGB(255, 255, 170, 0);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (i) => Icon(
          i < value ? Icons.star_rounded : Icons.star_border_rounded,
          color: starColor,
          size: size,
        ),
      ),
    );
  }
}
