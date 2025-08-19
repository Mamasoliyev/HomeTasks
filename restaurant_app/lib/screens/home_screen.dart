// import 'package:flutter/material.dart';
// import 'package:food_app/providers/resturant_provider.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   static final path = "/home";

//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => RestaurantProvider()..loadRestaurants(),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Home')),
//         body: Consumer<RestaurantProvider>(
//           builder: (context, provider, _) {
//             if (provider.loading) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (provider.restaurants.isEmpty) {
//               return Center(child: Text("No restaurants found."));
//             }

//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Masalan, 'Today New Available' bo‘limi uchun horizontal ro’yxat
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Today New Available',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 200,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: provider.restaurants.length,
//                       itemBuilder: (context, index) {
//                         final restaurant = provider.restaurants[index];
//                         // Har bir restoran ichidagi taomlardan bittasini olish (masalan, birinchi)
//                         final food = (restaurant['foods'] as List).isNotEmpty
//                             ? restaurant['foods'][0]
//                             : null;
//                         if (food == null) return SizedBox();

//                         return Container(
//                           width: 160,
//                           margin: EdgeInsets.symmetric(horizontal: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.shade300,
//                                 blurRadius: 5,
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(15),
//                                 ),
//                                 child: Image.network(
//                                   food['imageUrl'],
//                                   height: 120,
//                                   width: 160,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       food['name'],
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       restaurant['name'],
//                                       style: TextStyle(color: Colors.grey[600]),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   // Booking Restaurant bo‘limi - vertical ro’yxat
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Booking Restaurant',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: provider.restaurants.length,
//                     itemBuilder: (context, index) {
//                       final restaurant = provider.restaurants[index];
//                       return ListTile(
//                         leading: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(
//                             restaurant['imageUrl'] == 404 || restaurant['imageUrl']==null
//                                 ? 'https://cdn-icons-png.flaticon.com/512/3731/3731209.png'
//                                 : restaurant['imageUrl'],
//                             width: 60,
//                             height: 60,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         title: Text(restaurant['name']),
//                         subtitle: Text(restaurant['location']),
//                         trailing: ElevatedButton(
//                           onPressed: () {
//                             // Bu yerda booking action qo’yishingiz mumkin
//                           },
//                           child: Text('Book'),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:food_app/screens/all_fooods_screen.dart';
import 'package:food_app/screens/map_screen.dart';
import 'package:food_app/widgets/book_button.dart';
import 'package:food_app/widgets/produc_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:food_app/providers/resturant_provider.dart';

class HomeScreen extends StatefulWidget {
  static final path = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();

  List titleREklom = [];
  int selectPage = 0;
  int selectedPop = 1;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider()..loadRestaurants(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 241, 241),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 243, 241, 241),
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: Icon(Icons.menu, color: Colors.black),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Agrabad 435, Chittagong',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {},
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Consumer<RestaurantProvider>(
          builder: (context, provider, _) {
            if (provider.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.restaurants.isEmpty) {
              return Center(child: Text("No restaurants found."));
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.push(SearchScreen.path);
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Flash offer banner (mock)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 217,
                      width: double.infinity,

                      child: MyCarousel(),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Today New Arrivable
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today New Arivable',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "Best of the today  food list update",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(
                              AllFoodsScreen.path,
                              extra:
                                  provider.restaurants[selectedPop]['location'],
                            );
                          },
                          child: Text(
                            'See All >',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: SizedBox(
                      height: 270,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.restaurants.length,
                        itemBuilder: (context, index) {
                          selectedPop = index;

                          final restaurant = provider.restaurants[index];

                          log(restaurant['foods'].toString());

                          final food = (restaurant['foods'] as List).isNotEmpty
                              ? restaurant['foods'][0]
                              : null;

                          if (food == null) return SizedBox();

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            child: ProductWidget(
                              food: food,
                              restaurant: restaurant,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  // Booking Restaurants
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Booking Restaurant',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('See All', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    itemCount: provider.restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = provider.restaurants[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          padding: EdgeInsets.all(3),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                spreadRadius: 1,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),

                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                restaurant['image'] ?? '',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/3731/3731209.png',
                                      width: 60,
                                      height: 60,
                                    ),
                              ),
                            ),
                            title: Text(restaurant['name']),
                            subtitle: Text(restaurant['location']),
                            trailing: Buttonbooked(restaurant: restaurant),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 100),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyCarousel extends StatefulWidget {
  const MyCarousel({super.key});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int selectPage = 0;

  // ignore: non_constant_identifier_names
  List<String> foodImages = [
    "https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=800",
    "https://images.unsplash.com/photo-1447078806655-40579c2520d6?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzR8fGZvb2R8ZW58MHx8MHx8fDA%3D",
    "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzh8fGZvb2R8ZW58MHx8MHx8fDA%3D",
    "https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1610614991969-ceeb293e7ff5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDExfHx8ZW58MHx8fHx8",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: foodImages.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(foodImages[index], fit: BoxFit.cover),
                    Positioned(
                      left: 20,
                      top: 40,
                      bottom: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Flash Offer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "We are here with the best\ndeserts in town.",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),

                          Text("Order >", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true, // cheksiz scroll
            autoPlayInterval: Duration(seconds: 3),
            viewportFraction: 0.99,
            onPageChanged: (index, reason) {
              setState(() {
                selectPage = index;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            foodImages.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: selectPage == index ? 16 : 8,
              decoration: BoxDecoration(
                color: selectPage == index ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
