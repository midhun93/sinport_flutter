import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final LatLng airport = LatLng(1.3644, 103.9915); // Changi Airport example

    return Scaffold(
      backgroundColor: const Color(0xff071B2E),

      body: Stack(
        children: [

          FlutterMap(
            options: MapOptions(
              initialCenter: airport,
              initialZoom: 15,
            ),

            children: [

              TileLayer(
                urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.airport_app',
              ),

              MarkerLayer(
                markers: [
                  Marker(
                    point: airport,
                    width: 80,
                    height: 80,

                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Positioned(
            top: 60,
            left: 20,
            child: Text(
              "Airport Map",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}