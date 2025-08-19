import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/providers/resturant_provider.dart';

class AllFoodsScreen extends StatefulWidget {
  static const path = "/allFoods";

  final String location;
  const AllFoodsScreen({super.key, required this.location});

  @override
  State<AllFoodsScreen> createState() => _AllFoodsScreenState();
}

class _AllFoodsScreenState extends State<AllFoodsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<RestaurantProvider>(context, listen: false).loadRestaurants();

      if (!mounted) return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 241, 241),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromARGB(255, 243, 241, 241),

        title: const Text("All Foods"),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final allFoods = provider.restaurants
              .expand(
                (restaurant) =>
                    (restaurant['foods'] as List<Map<String, dynamic>>),
              )
              .toList();

          return SafeArea(
            child: GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 3 / 4,
              ),
              itemCount: allFoods.length,
              itemBuilder: (context, index) {
                final food = allFoods[index];

                return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey.shade300,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            width: double.infinity,
                            food['imageUrl'] ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                      Text(
                        food['name'] ?? 'No Name',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text(food['description']),
                    ],
                  ),
                );

                // ProductWidget(food: food, restaurant: provider.restaurants[0]);
              },
            ),
          );
        },
      ),
    );
  }
}
