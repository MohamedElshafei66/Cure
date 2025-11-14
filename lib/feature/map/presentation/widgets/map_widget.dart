import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final MapController mapController;
  final LatLng selectedLatLng;
  final Function(LatLng) onTap;

  const MapWidget({
    super.key,
    required this.mapController,
    required this.selectedLatLng,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: selectedLatLng,
        initialZoom: 15,
        onTap: (tapPosition, point) {
          onTap(LatLng(point.latitude, point.longitude));
        },
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=Y80ongSlzaC7GudgfIFA',
          userAgentPackageName: 'com.example.cure_app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: selectedLatLng,
              width: 60,
              height: 60,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

