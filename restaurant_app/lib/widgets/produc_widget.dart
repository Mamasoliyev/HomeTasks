import 'package:flutter/material.dart';
import 'package:food_app/screens/detail_food_screen.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.food,
    required this.restaurant,
  });

  final dynamic food;
  final Map<String, dynamic> restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailFoodScreen(food: food)),
        );  
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5,
              spreadRadius: 0.01,
            ),
          ],
        ),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                width: 160,

                height: 160,
                food['imageUrl'] ==
                            "https://images.unsplash.com/photo-1606755962773-0c8798463f56?auto=format&fit=crop&w=800&q=80" ||
                        food['imageUrl'] == null ||
                        food['imageUrl'] == ""
                    ? "https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGZvb2R8ZW58MHx8MHx8fDA%3D"
                    : food['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
            Text(
              food['name'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              children: [
                Icon(Icons.location_on_sharp, color: Colors.green),
                SizedBox(
                  width: 120,
                  child: Text(
                    maxLines: 2,
                    restaurant['name'],
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
