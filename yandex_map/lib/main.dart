import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CircleZoneMap());
  }
}

class CircleZoneMap extends StatefulWidget {
  @override
  _CircleZoneMapState createState() => _CircleZoneMapState();
}

class _CircleZoneMapState extends State<CircleZoneMap> {
  YandexMapController? _mapController;
  List<MapObject> _mapObjects = [];
  Point? _selectedPoint; // Foydalanuvchi tanlagan nuqta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radius Zone')),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onMapTap: (Point point) {
              _addCircleZone(point);
            },
            mapObjects: _mapObjects,
          ),
          if (_selectedPoint != null)
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                'Tanlangan nuqta: ${_selectedPoint!.latitude}, ${_selectedPoint!.longitude}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _addCircleZone(Point point) {
    setState(() {
      _selectedPoint = point; // Foydalanuvchi tanlagan nuqtani saqlash
      _mapObjects.clear(); // Oldingi obyektlarni tozalash

      // Dumaloq zona qo‘shish
      _mapObjects.add(
        CircleMapObject(
          mapId: MapObjectId('circle_zone'),
          circle: Circle(
            center: point,
            radius: 500, // Radius 500 metr
          ),
          strokeColor: Colors.red.withOpacity(0.5), // Chegara rangi
          strokeWidth: 2.0, // Chegara qalinligi
          fillColor: Colors.red.withOpacity(0.2), // Ichki rang
        ),
      );

      // Marker (metka) qo‘shish
      _mapObjects.add(
        PlacemarkMapObject(
          mapId: MapObjectId('selected_point'),
          point: point,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                'assets/end.png',
              ), // end.png fayli
              scale: 0.1, // Marker o‘lchami
              zIndex: 100,
            ),
          ),
        ),
      );
    });
  }
}
