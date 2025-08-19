import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_app/screens/detail_resturant_screen.dart';

class RestaurantDetailSheet extends StatelessWidget {
  static final path = "/detail_res";
  final Map<String, dynamic> restaurant;

  const RestaurantDetailSheet({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    log(restaurant['foods'].toString());
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                restaurant['image'] ?? '',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.restaurant, size: 100),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                restaurant['name'] ?? '',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_pin, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    restaurant['location'] ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  "Open today: ${restaurant['openTime'] ?? '10:00 AM'} - ${restaurant['closeTime'] ?? '12:00 PM'}",
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                log("Restaurant: $restaurant");
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailResturantScreen(
                      foods: restaurant['foods'] ?? [],
                      restaurant: restaurant
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Booking"),
            ),
          ],
        ),
      ),
    );
  }
}
