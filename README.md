# Favorite Places

A Flutter app to save the places that matter to you — with a photo and the exact location, all in one spot.

---

## What it does

You can add any place by giving it a name, snapping a photo with your camera, and pinning its location either through your device's GPS or by tapping directly on a map. Every saved place shows up in your list with a thumbnail and the coordinates. Tap a place to see the full image.

---

## Screens

**Your Places** — the home screen. Lists all your saved places. Empty state shows a message until you add something. The `+` button in the top-right takes you to the add screen.

**Add a New Place** — a form with three inputs:
- a title field
- a camera capture widget (tap to retake the photo)
- a location picker with two options: grab your current GPS position, or open a full map and tap to choose manually

All three fields are required before saving. Missing any one of them shows a snackbar warning.

**Map (pick mode)** — an interactive OpenStreetMap view. Tap anywhere to drop a marker. Hit the save icon in the app bar to confirm the picked coordinates and return to the add screen.

**Place Details** — full-screen image of the saved place.

---

## Tech stack

| What | Package |
|---|---|
| State management | `flutter_riverpod` |
| Maps | `flutter_map` + `latlong2` |
| Map tiles | OpenStreetMap (no API key needed) |
| Device location | `location` + `geolocator` |
| Camera / gallery | `image_picker` |
| Fonts | `google_fonts` (Ubuntu Condensed + Lato) |
| Unique IDs | `uuid` |
| HTTP | `http` |

---

## Project layout

```
lib/
├── main.dart               # app entry, theme setup
├── Models/
│   └── place.dart          # Place and PlaceLocation data classes
├── Providers/
│   └── user_places.dart    # Riverpod notifier, holds the places list in memory
├── Screens/
│   ├── places.dart         # home screen
│   ├── add_place.dart      # add new place form
│   ├── place_details.dart  # full image view
│   └── map.dart            # interactive map (pick or view mode)
└── Widgets/
    ├── image_input.dart    # camera capture widget
    ├── location_input.dart # GPS + map picker widget with inline preview map
    └── places_list.dart    # list tile renderer
```

---

## Running the app

Make sure Flutter is set up, then:

```bash
flutter pub get
flutter run
```

The app targets Android, iOS, Windows, Linux, and web out of the box — whatever your Flutter setup supports.

**Android/iOS only:** location and camera permissions are required at runtime. The OS will prompt for them when you first use those features.

---

## Notes

- Places are kept in memory only — there is no database or local storage wired up yet, so the list resets when you close the app.
- Location coordinates are stored as raw lat/lng values. No reverse geocoding is done; the address string is just a formatted `lat / lng` label.
- The map defaults to Google's campus (37.422, -122.084) as a fallback starting point when no location has been picked yet.
- The app uses a dark purple theme throughout.
