import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailFoodScreen extends StatefulWidget {
  final Map<String, dynamic> food;
  const DetailFoodScreen({super.key, required this.food});

  @override
  State<DetailFoodScreen> createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  @override
  Widget build(BuildContext context) {
    final food = widget.food;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          food['name'] ?? 'Food Detail',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Food Image
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.network(
                food['imageUrl'] ??
                    "https://via.placeholder.com/600x400.png?text=No+Image",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// Food Info
            Text(
              food['name'] ?? "Unknown Food",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            /// Description
            Text(
              // maxLines: 6,
              """${food['description']} A delightful blend of fresh ingredients crafted to perfection.
Rich flavors come together in every bite, creating harmony.
Prepared with care to bring warmth and satisfaction.
An experience that excites the senses and comforts the soul.""",
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),

            Row(
              children: [
                Icon(Icons.access_time, color: Colors.green.shade600, size: 30),
                const SizedBox(width: 8),
                Text(
                  " open closed :  ${DateFormat('HH:mm').format((food['createdAt'] as Timestamp).toDate())}",
                ),
              ],
            ),
          ],
        ),
      ),

      /// Bottom Add to Cart Button
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "food price : ${food['price']} \$",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 60),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // TODO: Add to cart logic
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
