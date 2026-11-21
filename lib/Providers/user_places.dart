import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/Models/place.dart';

class UserPlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() => [];

  void addPlace(String title, File image, PlaceLocation location) {
    final newPlace = Place(title: title, image: image, location: location);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider = NotifierProvider<UserPlacesNotifier, List<Place>>(
  () => UserPlacesNotifier(),
);
