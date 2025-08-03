// import 'package:flutter/material.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: MapScreen());
//   }
// }

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late YandexMapController _mapController;
//   final List<MapObject> _mapObjects = [];
//   final TextEditingController _searchController = TextEditingController();
//   Point? _selectedPoint;

//   // Map obyektlarini saqlash uchun MapObjectId
//   final MapObjectId _placemarkId = MapObjectId('selected_place');

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   // Qidiruv funksiyasi
//   Future<void> _searchPlace(String query) async {
//     if (query.isEmpty) return;

//     // Yandex Search API orqali qidiruv (masalan, geocode)
//     // Bu yerda haqiqiy API chaqiruvi bo‘lishi kerak, ammo misol sifatida oddiy natija
//     // API chaqiruvi uchun `http` paketidan foydalanib Yandex Geocoder API’ga murojaat qilishingiz mumkin
//     final result = Point(
//       latitude: 41.311081,
//       longitude: 69.240562,
//     ); // Toshkent koordinatalari misol uchun

//     setState(() {
//       _selectedPoint = result;
//       _mapObjects.clear(); // Oldingi markerlarni o‘chirish

//       // Placemark qo‘shish
//       _mapObjects.add(
//         PlacemarkMapObject(
//           mapId: _placemarkId,
//           point: result,
//           icon: PlacemarkIcon.single(
//             PlacemarkIconStyle(
//               rotationType: RotationType.rotate,
//               image: BitmapDescriptor.fromAssetImage('assets/end.png'),

//               scale: 0.1,
//             ),
//           ),

//           text: PlacemarkText(
//             text: query,
//             style: PlacemarkTextStyle(
//               color: const Color.fromARGB(255, 10, 28, 58),
//               size: 12,
//             ),
//           ),
//           onTap: (mapObject, point) {
//             // Marker bosilganda ma’lumot ko‘rsatish
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text('Manzil: $query')));
//           },
//         ),
//       );
//     });

//     // Kamerani qidiruv natijasiga yo‘naltirish
//     await _mapController.moveCamera(
//       CameraUpdate.newCameraPosition(CameraPosition(target: result, zoom: 15)),
//       animation: MapAnimation(type: MapAnimationType.smooth, duration: 1.5),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Yandex Map Qidiruv')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Manzilni kiriting',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     _searchPlace(_searchController.text);
//                   },
//                 ),
//               ),
//               onSubmitted: _searchPlace,
//             ),
//           ),
//           Expanded(
//             child: YandexMap(
//               onMapCreated: (controller) async {
//                 _mapController = controller;
//                 // Dastlabki kamera pozitsiyasi
//                 await _mapController.moveCamera(
//                   CameraUpdate.newCameraPosition(
//                     CameraPosition(
//                       target: Point(latitude: 41.311081, longitude: 69.240562),
//                       zoom: 10,
//                     ),
//                   ),
//                 );
//               },
//               mapObjects: _mapObjects,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }