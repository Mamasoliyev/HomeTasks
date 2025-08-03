import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_lesson/screens/seaarch_delegate.dart';
import 'package:google_maps_lesson/services/search_api_service.dart';

class SempleScreen extends StatefulWidget {
  final LatLng location;
  const SempleScreen({super.key, required this.location});

  @override
  State<SempleScreen> createState() => _SempleScreenState();
}

class _SempleScreenState extends State<SempleScreen> {
  late LatLng _center;
  late Set<Marker> markers;
  late Set<Polyline> polylines;
  late Set<Circle> circles;
  late GoogleMapController _mapController;
  LatLng? _currentLocation;
  final PlacesService _placesService = PlacesService();
  MapType _currentMapType = MapType.normal; // Xarita turi uchun o‘zgaruvchi

  @override
  void initState() {
    super.initState();
    _center = widget.location;
    markers = {
      Marker(
        markerId: const MarkerId("najot"),
        position: _center,
        infoWindow: const InfoWindow(title: "Boshlang‘ich joy"),
      ),
    };
    polylines = {};
    circles = {};
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Joylashuv xizmati o‘chirilgan');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Joylashuv ruxsati rad etildi');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log('Joylashuv ruxsati doimiy rad etildi');
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        markers.add(
          Marker(
            markerId: const MarkerId("current"),
            position: _currentLocation!,
            infoWindow: const InfoWindow(title: "Hozirgi joy"),
          ),
        );
        _center = _currentLocation!;
        _mapController.animateCamera(CameraUpdate.newLatLng(_center));
      });
    }
  }

  Future<void> _addRouteAndCircle(LatLng destination) async {
    if (_currentLocation == null) {
      log('Hozirgi joylashuv aniqlanmadi');
      return;
    }

    if (!mounted) return;

    final routePoints = await _placesService.getRoute(
      _currentLocation!,
      destination,
      isCancelled: () => !mounted,
    );

    if (routePoints != null && mounted) {
      setState(() {
        // Yangi marker qo‘shish
        markers.add(
          Marker(
            markerId: MarkerId(destination.toString()),
            position: destination,
            infoWindow: const InfoWindow(title: "Manzil"),
          ),
        );
        // Yo‘l qo‘shish
        polylines.add(
          Polyline(
            polylineId: PolylineId(destination.toString()),
            points: routePoints,
            color: Colors.blue,
            width: 5,
          ),
        );
        // 500m radiusli doira qo‘shish
        circles.add(
          Circle(
            circleId: CircleId(destination.toString()),
            center: destination,
            radius: 500, // 500 metr
            fillColor: Colors.blue.withOpacity(0.3),
            strokeColor: Colors.blue,
            strokeWidth: 2,
          ),
        );
        // Xarita markazini yangilash
        _center = destination;
        _mapController.animateCamera(CameraUpdate.newLatLng(destination));
      });
    }
  }

  void _clearMap() {
    if (!mounted) return;
    setState(() {
      // Faqat boshlang‘ich va hozirgi joy markerlarini saqlash
      markers.removeWhere(
        (marker) =>
            marker.markerId.value != "najot" &&
            marker.markerId.value != "current",
      );
      polylines.clear();
      circles.clear();
    });
  }

  void _changeMapType() {
    if (!mounted) return;
    setState(() {
      // Xarita turini aylantirish
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : _currentMapType == MapType.satellite
          ? MapType.terrain
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map Example"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              log("Qidiruv bosildi");
              final result = await showSearch<LatLng?>(
                context: context,
                delegate: SearchScreen(),
              );
              if (result != null && mounted) {
                await _addRouteAndCircle(result);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: _changeMapType,
            tooltip: 'Xarita turini o‘zgartirish',
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearMap,
            tooltip: 'Xaritani tozalash',
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _center, zoom: 12),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        markers: markers,
        polylines: polylines,
        circles: circles,
        mapType: _currentMapType, // Xarita turi
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
