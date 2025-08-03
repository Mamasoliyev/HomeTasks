// import 'package:flutter/material.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: RouteMap());
//   }
// }

// class RouteMap extends StatefulWidget {
//   @override
//   _RouteMapState createState() => _RouteMapState();
// }

// class _RouteMapState extends State<RouteMap> {
//   YandexMapController? _mapController;
//   final TextEditingController _startController = TextEditingController();
//   final TextEditingController _endController = TextEditingController();
//   List<MapObject> _mapObjects = [];
//   String? _distance;
//   String? _duration;

//   Future<Point?> _getCoordinates(String address) async {
//     final searchSession = YandexSearch.searchByText(
//       searchText: address,
//       geometry: Geometry.fromBoundingBox(
//         BoundingBox(
//           southWest: Point(latitude: 41.0, longitude: 69.0),
//           northEast: Point(latitude: 42.0, longitude: 70.0),
//         ),
//       ),
//       searchOptions: SearchOptions(),
//     );

//     final searchResult = await searchSession.then(
//       (value) => value.$2.then((value) => value),
//     );

//     if (searchResult.items != null && searchResult.items!.isNotEmpty) {
//       return searchResult.items!.first.geometry.first.point;
//     }
//     return null;
//   }

//   Future<void> _buildRoute() async {
//     if (_startController.text.isEmpty || _endController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             "Iltimos, boshlang‘ich va yakuniy manzillarni kiriting",
//           ),
//         ),
//       );
//       return;
//     }

//     final startPoint = await _getCoordinates(_startController.text);
//     final endPoint = await _getCoordinates(_endController.text);

//     if (startPoint == null || endPoint == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Manzil topilmadi, qayta urinib ko‘ring")),
//       );
//       return;
//     }

//     final drivingSession = YandexDriving.requestRoutes(
//       points: [
//         RequestPoint(
//           point: startPoint,
//           requestPointType: RequestPointType.wayPoint,
//         ),
//         RequestPoint(
//           point: endPoint,
//           requestPointType: RequestPointType.wayPoint,
//         ),
//       ],
//       drivingOptions: DrivingOptions(),
//     );

//     final drivingResult = await drivingSession.then((value) => value.$2);

//     if (drivingResult.routes != null && drivingResult.routes!.isNotEmpty) {
//       final route = drivingResult.routes!.first;

//       setState(() {
//         _mapObjects.clear();

//         _mapObjects.addAll([
//           PlacemarkMapObject(
//             mapId: MapObjectId('start'),
//             point: startPoint,
//             icon: PlacemarkIcon.single(
//               PlacemarkIconStyle(
//                 image: BitmapDescriptor.fromAssetImage('assets/start.png'),
//                 scale: 0.08,
//               ),
//             ),
//           ),
//           PlacemarkMapObject(
//             mapId: MapObjectId('end'),
//             point: endPoint,
//             icon: PlacemarkIcon.single(
//               PlacemarkIconStyle(
//                 image: BitmapDescriptor.fromAssetImage('assets/end.png'),
//                 scale: 0.08,
//               ),
//             ),
//           ),
//           PolylineMapObject(
//             mapId: MapObjectId('route'),
//             polyline: Polyline(points: route.geometry.points),
//             strokeColor: Colors.blue,
//             strokeWidth: 4.0,
//           ),
//         ]);

//         _distance =
//             "${(route.metadata.weight.distance.value! / 1000).toStringAsFixed(2)} km";
//         _duration = "${(route.metadata.weight.time.value! / 60).floor()} minut";

//         _mapController?.moveCamera(
//           CameraUpdate.newBounds(
//             BoundingBox(
//               southWest: Point(
//                 latitude: route.geometry.points
//                     .map((p) => p.latitude)
//                     .reduce((a, b) => a < b ? a : b),
//                 longitude: route.geometry.points
//                     .map((p) => p.longitude)
//                     .reduce((a, b) => a < b ? a : b),
//               ),
//               northEast: Point(
//                 latitude: route.geometry.points
//                     .map((p) => p.latitude)
//                     .reduce((a, b) => a > b ? a : b),
//                 longitude: route.geometry.points
//                     .map((p) => p.longitude)
//                     .reduce((a, b) => a > b ? a : b),
//               ),
//             ),
//           ),
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Marshrut topilmadi")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Marshrut Chizish')),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _startController,
//                   decoration: InputDecoration(
//                     labelText: 'Qayerdansiz?',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _endController,
//                   decoration: InputDecoration(
//                     labelText: 'Qayerga borasiz?',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _buildRoute,
//                   child: Text('Marshrut Chizish'),
//                 ),
//                 if (_distance != null && _duration != null)
//                   Padding(
//                     padding: EdgeInsets.only(top: 10),
//                     child: Text(
//                       'Masofa: $_distance\nVaqt: $_duration',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: YandexMap(
//               onMapCreated: (controller) {
//                 _mapController = controller;
//                 controller.moveCamera(
//                   CameraUpdate.newCameraPosition(
//                     CameraPosition(
//                       target: Point(latitude: 41.2995, longitude: 69.2401),
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
