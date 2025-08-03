import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CurrentLocationMap());
  }
}

class CurrentLocationMap extends StatefulWidget {
  @override
  _CurrentLocationMapState createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  YandexMapController? _mapController;
  List<MapObject> _mapObjects = [];
  Point? _currentLocation;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Geolokatsiya xizmati yoqilganligini tekshirish
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Geolokatsiya xizmati yoqilmagan')),
      );
      return;
    }

    // Ruxsatni tekshirish
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Geolokatsiya uchun ruxsat berilmadi')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Geolokatsiya uchun ruxsat doimiy rad etilgan')),
      );
      return;
    }

    // Hozirgi joylashuvni olish
    final position = await Geolocator.getCurrentPosition();
    _currentLocation = Point(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    // Xaritada markazga olib borish va marker qo‘yish
    setState(() {
      _mapObjects.add(
        PlacemarkMapObject(
          mapId: MapObjectId('current_location'),
          point: _currentLocation!,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/end.png'),
              scale: 0.1,
            ),
          ),
          opacity: 0.9,
          text: PlacemarkText(
            text: 'Men turgan joyim',
            style: PlacemarkTextStyle(color: Colors.black, size: 12),
          ),
        ),
      );

      _mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentLocation!, zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hozirgi joylashuv')),
      body: YandexMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        mapObjects: _mapObjects,
      ),
    );
  }
}
