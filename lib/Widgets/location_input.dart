import 'dart:convert';

import 'package:favorite_places/Models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart'
    show Location, LocationData, PermissionStatus;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, this.onSelectLocation});
  final void Function(PlaceLocation location)? onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;
  final MapController _previewMapController = MapController();

  static const String _userAgent = 'com.favoriteplaces.app';

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    final formatedAddress =
        'lat": ${lat.toStringAsFixed(5)}, "lng": ${lng.toStringAsFixed(5)}';

    final newLocation = PlaceLocation(
      latitude: lat,
      longitude: lng,
      address: formatedAddress,
    );
    setState(() {
      _pickedLocation = newLocation;
      _isGettingLocation = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _previewMapController.move(LatLng(lat, lng), 15);
      }
    });
    widget.onSelectLocation?.call(newLocation);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Location Chosen',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      textAlign: TextAlign.center,
    );

    if (_pickedLocation != null) {
      final point = LatLng(
        _pickedLocation!.latitude,
        _pickedLocation!.longitude,
      );
      previewContent = FlutterMap(
        mapController: _previewMapController,
        // key: ValueKey('${point.latitude}_${point.longitude}'),
        options: MapOptions(
          initialZoom: 15,
          initialCenter: point,
          interactionOptions: InteractionOptions(flags: InteractiveFlag.none),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: _userAgent,
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: point,
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
        ],
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.5),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            ),
          ],
        ),
      ],
    );
  }
}
