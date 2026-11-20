import 'package:favorite_places/Models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.location, this.isSelecting = true});

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    final initialPoint = LatLng(
      widget.location.latitude,
      widget.location.longitude,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation ?? initialPoint);
              },
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialZoom: 16,
          initialCenter: initialPoint,
          onTap: widget.isSelecting
              ? null
              : (tapPosition, point) => setState(() {
                  _pickedLocation = point;
                }),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.favoriteplaces.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _pickedLocation ?? initialPoint,
                height: 40,
                width: 40,
                child: Icon(
                  Icons.location_pin,
                  color: Color(Colors.red.withValues(alpha: 0.8).toARGB32()),
                  size: 40,
                ),
              ),
            ],
          ),
          RichAttributionWidget(
            attributions: [TextSourceAttribution('OpenStreetMap')],
          ),
        ],
      ),
    );
  }
}
