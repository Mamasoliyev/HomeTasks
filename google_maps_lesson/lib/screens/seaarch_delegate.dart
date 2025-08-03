import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_lesson/services/search_api_service.dart';

class SearchScreen extends SearchDelegate<LatLng?> {
  final PlacesService placesService = PlacesService();
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: placesService.searchPlaces(query, isCancelled: () => _isDisposed),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Natijalar topilmadi'));
        }

        final results = snapshot.data!;
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final place = results[index];
            return ListTile(
              title: Text(place['description']),
              onTap: () async {
                if (_isDisposed) return;
                final details = await placesService.getPlaceDetails(
                  place['place_id'],
                  isCancelled: () => _isDisposed,
                );
                if (details != null && !_isDisposed) {
                  final lat = details['geometry']['location']['lat'];
                  final lng = details['geometry']['location']['lng'];
                  close(context, LatLng(lat, lng));
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: placesService.searchPlaces(query, isCancelled: () => _isDisposed),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Takliflar yo‘q'));
        }

        final suggestions = snapshot.data!;
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              title: Text(suggestion['description']),
              onTap: () {
                if (_isDisposed) return;
                query = suggestion['description'];
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}