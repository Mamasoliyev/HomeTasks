import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class SearchScreen extends StatefulWidget {
  static const path = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GoogleMapController? mapController;

  LatLng? _currentPosition;
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};
  final Set<Polyline> _polylines = {};

  final String _googleApiKey = "AIzaSyBYhwdSYmrN9lZuLyjQIIwtOWPB8PcX7fs";

  final Map<String, LatLng> restaurants = {
    "Oqtepa Lavash - Chilonzor": LatLng(41.2962, 69.2034),
    "Evos - Mirzo Ulug'bek": LatLng(41.3385, 69.3342),
    "Black Star Burger - Center": LatLng(41.3116, 69.2790),
    "KFC - Samarqand Darvoza": LatLng(41.3022, 69.2482),
    "Bukhara Restaurant - Yunusobod": LatLng(41.3532, 69.2867),
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied.");
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(pos.latitude, pos.longitude);

      _markers.add(
        Marker(
          markerId: const MarkerId("me"),
          position: _currentPosition!,
          infoWindow: const InfoWindow(title: "Sizning joyingiz"),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
      );

      for (var entry in restaurants.entries) {
        _markers.add(
          Marker(
            markerId: MarkerId(entry.key),
            position: entry.value,
            infoWindow: InfoWindow(title: entry.key),
            onTap: () {
              _drawRoute(entry.value);
            },
          ),
        );

        _circles.add(
          Circle(
            circleId: CircleId(entry.key),
            center: entry.value,
            radius: 200,
            strokeColor: Colors.blue,
            fillColor: Colors.blue.withOpacity(0.2),
            strokeWidth: 2,
          ),
        );
      }
    });
  }

  Future<void> _drawRoute(LatLng destination) async {
    if (_currentPosition == null) return;

    PolylinePoints polylinePoints = PolylinePoints(apiKey: _googleApiKey);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        ),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = [];
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            color: Colors.blue,
            width: 5,
            points: polylineCoordinates,
          ),
        );
      });

      mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          _boundsFromLatLngList([_currentPosition!, destination]),
          60,
        ),
      );
    }
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double x0 = list.first.latitude, x1 = list.first.latitude;
    double y0 = list.first.longitude, y1 = list.first.longitude;
    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }
    return LatLngBounds(southwest: LatLng(x0, y0), northeast: LatLng(x1, y1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) => mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 12.3,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: _markers,
                  circles: _circles,
                  polylines: _polylines,
                ),

                /// Search
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search restaurants...",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12),
                      ),
                      onChanged: (value) {
                        // Optional: filter qilish mumkin
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
