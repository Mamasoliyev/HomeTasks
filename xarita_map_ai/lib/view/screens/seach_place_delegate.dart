import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xarita_map_ai/main.dart';
class PlaceSearchDelegate extends SearchDelegate {
  final Function(LatLng, String) onPlaceSelected;

  PlaceSearchDelegate({required this.onPlaceSelected});

  Future<List<Map<String, dynamic>>> fetchSuggestions(String input) async {
    const String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final response = await http.get(Uri.parse(
        '$baseUrl?input=$input&key=$googleApiKey&types=geocode&language=uz'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final predictions = json['predictions'] as List;
      return predictions
          .map((p) => {
                'description': p['description'],
                'place_id': p['place_id'],
              })
          .toList();
    }
    return [];
  }

  Future<LatLng?> getPlaceLatLng(String placeId) async {
    const String baseUrl =
        'https://maps.googleapis.com/maps/api/place/details/json';
    final response = await http
        .get(Uri.parse('$baseUrl?place_id=$placeId&key=$googleApiKey'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final location = json['result']['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    }
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchSuggestions(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        final suggestions = snapshot.data!;
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              title: Text(suggestion['description']),
              onTap: () async {
                final latLng = await getPlaceLatLng(suggestion['place_id']);
                if (latLng != null) {
                  onPlaceSelected(latLng, suggestion['description']);
                  close(context, null);
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  @override
  Widget buildResults(BuildContext context) => Container();
}
