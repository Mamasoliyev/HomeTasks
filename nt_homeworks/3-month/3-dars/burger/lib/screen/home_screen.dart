import 'package:burger/data/products_data.dart';
import 'package:burger/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ProductModel> products = productsData
      .map((e) => ProductModel.fromJson(e))
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppBar(),
            SizedBox(height: 16),
            Text(
              "   Popular Burgers",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            buildGridView(),
          ],
        ),
      ),
    );
  }

  Expanded buildGridView() {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 3 / 4,
        ),
        itemCount: 6, // vaqtincha 6 dona item
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => context.go('/detail', extra: products[index]),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: products[index].name!,
                      child: Image.asset(
                        "assets/burger.jpg",
                        fit: BoxFit.cover,
                        height: 150,
                        width: 170,
                      ),
                    ),
                    Text(
                      products[index].name!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      products[index].size!,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${products[index].price!.toStringAsFixed(2)}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFECF0F4),
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 18),
            ),

            // "BURGER" drop-down button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Text(
                    "BURGER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121223),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_drop_down, color: Colors.orange),
                ],
              ),
            ),

            // Search button
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF121223),
              ),
              child: Icon(Icons.search, color: Colors.white),
            ),

            // Filter button
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFECF0F4),
              ),
              child: Icon(Icons.tune, color: Color(0xFF121223)),
            ),
          ],
        ),
      ),
    );
  }
}
