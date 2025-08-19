import 'package:flutter/material.dart';
import 'package:food_app/screens/detail_sheet.dart';
import 'package:provider/provider.dart';
import 'package:food_app/providers/book_provider.dart';

class BookScreen extends StatelessWidget {
  static final path = "/book";

  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Booking History", style: TextStyle(color: Colors.white)),
      ),
      body: bookProvider.bookedRestaurants.isEmpty
          ? Center(child: Text("No booked restaurants yet."))
          : ListView.separated(
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              itemCount: bookProvider.bookedRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = bookProvider.bookedRestaurants[index];
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  child: Row(
                    spacing: 10,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: Image.network(
                          restaurant['image'] ?? "",
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Icon(Icons.restaurant),
                        ),
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.green,
                                size: 25,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  restaurant['location'],
                                  maxLines: 2,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),

                              // Spacer(),
                              SizedBox(width: 56),
                              TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
                                  ),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  backgroundColor: Colors.green,
                                ),

                                onPressed: () {
                                  showModalBottomSheet(
                                    useRootNavigator: true,
                                    enableDrag: true,
                                    isDismissible: true,
                                    showDragHandle: true,
                                    backgroundColor: Colors.white,

                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    builder: (_) => RestaurantDetailSheet(
                                      restaurant: {
                                        'name': restaurant['name'],
                                        'location': restaurant['location'],
                                        'image': restaurant['image'],
                                        'openTime':
                                            "10:00 AM", // yoki dynamic ber
                                        'closeTime': "12:00 PM",
                                        'foods': restaurant['foods'],
                                      },
                                    ),
                                  );
                                },

                                child: Text("Check"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
