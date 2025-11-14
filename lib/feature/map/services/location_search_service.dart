import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationSearchResult {
  final String name;
  final String displayName;
  final LatLng coordinates;

  LocationSearchResult({
    required this.name,
    required this.displayName,
    required this.coordinates,
  });
}

class LocationSearchService {
  // Using Nominatim (OpenStreetMap) - free geocoding service
  static const String _baseUrl = 'https://nominatim.openstreetmap.org/search';

  static Future<List<LocationSearchResult>> searchLocation(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {
          'q': query,
          'format': 'json',
          'limit': '5',
          'addressdetails': '1',
        },
      );

      final response = await http.get(
        uri,
        headers: {'User-Agent': 'CureApp/1.0'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) {
          return LocationSearchResult(
            name: item['display_name'] ?? '',
            displayName: item['display_name'] ?? '',
            coordinates: LatLng(
              double.parse(item['lat'] ?? '0'),
              double.parse(item['lon'] ?? '0'),
            ),
          );
        }).toList();
      }
    } catch (e) {
      // Return empty list on error
    }

    return [];
  }

  // Reverse geocoding: Get address from coordinates
  static Future<String> getAddressFromCoordinates(LatLng coordinates) async {
    try {
      final uri = Uri.parse('https://nominatim.openstreetmap.org/reverse')
          .replace(
            queryParameters: {
              'lat': coordinates.latitude.toString(),
              'lon': coordinates.longitude.toString(),
              'format': 'json',
              'addressdetails': '1',
            },
          );

      final response = await http.get(
        uri,
        headers: {'User-Agent': 'CureApp/1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['display_name'] as String?;
        if (address != null && address.isNotEmpty) {
          // Format address to show a shorter version
          final parts = address.split(',');
          if (parts.length > 2) {
            // Return last 3 parts (usually street, city, country)
            return parts.sublist(parts.length - 3).join(', ').trim();
          }
          return address;
        }
      }
    } catch (e) {
      // Return default on error
    }

    return 'Location';
  }
}
