import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/Models/place.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<sql.Database> _getdatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() => [];

  void loadplaces() async {
    final db = await _getdatabase();
    final data = await db.query('user_places');
    final places = data.map((row) {
      return Place(
        id: row['id'] as String,
        title: row['title'] as String,
        image: File(row['image'] as String),
        location: PlaceLocation(
          latitude: row['loc_lat'] as double,
          longitude: row['loc_lng'] as double,
          address: row['address'] as String,
        ),
      );
    }).toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final addDirec = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${addDirec.path}/$fileName');

    final newPlace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );

    final db = await _getdatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
    state = [newPlace, ...state];
  }
}

final userPlacesProvider = NotifierProvider<UserPlacesNotifier, List<Place>>(
  () => UserPlacesNotifier(),
);
