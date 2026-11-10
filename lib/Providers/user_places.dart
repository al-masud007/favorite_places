import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/Models/place.dart';
import 'package:location/location.dart';

class UserPlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() => [];

  void addPlace(String title, File image) {
    final newPlace = Place(
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: 0.0,
        longitude: 0.0,
        address: 'Unknown location',
      ),
    );
    state = [newPlace, ...state];
  }
}

final userPlacesProvider = NotifierProvider<UserPlacesNotifier, List<Place>>(
  () => UserPlacesNotifier(),
);
