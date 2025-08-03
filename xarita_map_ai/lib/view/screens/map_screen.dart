import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xarita_map_ai/main.dart';
import 'package:http/http.dart' as http;
import 'package:xarita_map_ai/view/screens/location_storage.dart';
import 'package:xarita_map_ai/view/screens/poem_screen.dart';
import 'package:xarita_map_ai/view/screens/seach_place_delegate.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  LatLng? _currentLatLng;
  Marker? _selectedMarker;
  Set<Polyline> _polylines = {};
  Set<Circle> _circles = {};
  List<Marker> _markers = [];
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedLocations();
    _loadSavedMarker();
    _determinePosition();
  }

  void _loadSavedLocations() async {
    final locations = await LocationStorage.loadLocations();

    for (var loc in locations) {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final LatLng pos = LatLng(loc['lat'], loc['lng']);

      final marker = Marker(
        markerId: MarkerId(id),
        position: pos,
        infoWindow: InfoWindow(title: "Saqlangan joy"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PoemScreen(initialContent: contentController.text),
            ),
          );
        },
      );

      final circle = Circle(
        circleId: CircleId(id),
        center: pos,
        radius: 300,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      );

      setState(() {
        _markers.add(marker);
        _circles.add(circle);
      });
    }
  }

  Future<void> clearSavedLocations() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .remove('locationList'); // yoki .clear() barcha maʼlumotlarni o‘chiradi
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLatLng = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _loadSavedMarker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? lat = prefs.getDouble('saved_lat');
    double? lng = prefs.getDouble('saved_lng');
    if (lat != null && lng != null) {
      setState(() {
        _selectedMarker = Marker(
          markerId: MarkerId('saved_marker'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: 'Saved Location'),
        );
      });
    }
  }

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    const R = 6371000; // Yer radiusi (metrlarda)
    final dLat = (lat2 - lat1) * pi / 180;
    final dLon = (lon2 - lon1) * pi / 180;
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  bool _isWithinAnyRadius(LatLng tapPosition) {
    for (var marker in _markers) {
      double distance = _calculateDistance(
        tapPosition.latitude,
        tapPosition.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );
      if (distance <= 300) return true;
    }
    return false;
  }

  Future<void> _saveMarkerLocation(LatLng latLng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('saved_lat', latLng.latitude);
    await prefs.setDouble('saved_lng', latLng.longitude);
  }

  void _onMapTap(LatLng latLng) async {
    if (_isWithinAnyRadius(latLng)) return;

    final id = DateTime.now().millisecondsSinceEpoch.toString();

    final marker = Marker(
      markerId: MarkerId(id),
      position: latLng,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PoemScreen(initialContent: contentController.text)));
      },
      infoWindow: InfoWindow(title: 'Tanlangan joy'),
    );

    final circle = Circle(
      circleId: CircleId(id),
      center: latLng,
      radius: 300,
      fillColor: Colors.blue.withOpacity(0.2),
      strokeColor: Colors.blue,
      strokeWidth: 2,
      consumeTapEvents: true,
      onTap: () async {
        setState(() {
          _markers.removeWhere((m) => m.markerId.value == id);
          _circles.removeWhere((c) => c.circleId.value == id);
        });
      },
    );

    setState(() {
      _markers.add(marker);
      _circles.add(circle);
    });

    await LocationStorage.saveLocation(latLng.latitude, latLng.longitude, contentController.text);

    await _saveMarkerLocation(latLng);
    await showStoryInputDialog().then((story) {
      if (story != null && story.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hikoya saqlandi: $story')),
        );
      }
    });
  }

  Future<String?> showStoryInputDialog() async {
    String userInput = '';

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hikoya yozing"),
        content: TextField(
          controller: contentController,
          autofocus: true,
          maxLines: 3,
          decoration:
              const InputDecoration(hintText: "Qanday hikoya qoldirmoqchisiz?"),
          onChanged: (value) => userInput = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text("Bekor qilish"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, userInput),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _drawRoute() async {
    if (_currentLatLng == null || _selectedMarker == null) return;

    PolylinePoints polylinePoints = PolylinePoints();

    final request = PolylineRequest(
      origin: PointLatLng(_currentLatLng!.latitude, _currentLatLng!.longitude),
      destination: PointLatLng(
        _selectedMarker!.position.latitude,
        _selectedMarker!.position.longitude,
      ),
      mode: TravelMode.driving,
    );

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: request,
      googleApiKey: googleApiKey,
    );

    if (result.points.isNotEmpty) {
      setState(
        () {
          _polylines = {
            Polyline(
              polylineId: const PolylineId("route"),
              color: Colors.blue,
              width: 5,
              points: result.points
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
            ),
          };
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Yo‘l topilmadi.')),
      );
    }
  }

  void _onSearchPressed() {
    showSearch(
      context: context,
      delegate:
          PlaceSearchDelegate(onPlaceSelected: (LatLng latLng, String name) {
        _mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
        _onMapTap(latLng);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xarita'),
        actions: [
          IconButton(
              onPressed: _onSearchPressed, icon: const Icon(Icons.search)),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Barcha joylarni o‘chirish',
            onPressed: () async {
              LocationStorage.clearLocations();
              setState(() {
                _markers.clear();
                _circles.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Barcha saqlangan joylar o‘chirildi')),
              );
            },
          )
        ],
      ),
      body: _currentLatLng == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _currentLatLng!, zoom: 15),
              onMapCreated: (controller) => _mapController = controller,
              markers: {
                ..._markers,
                Marker(
                  markerId: MarkerId('me'),
                  position: _currentLatLng!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                  infoWindow: InfoWindow(title: 'Siz turgan joy'),
                )
              },
              onTap: _onMapTap,
              polylines: _polylines,
              myLocationEnabled: true,
              circles: _circles,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _drawRoute,
        child: Icon(Icons.alt_route),
      ),
    );
  }
}
