# Favorite Places

A Flutter app to save the places you visit — photo, pinpoint location, and human-readable address all stored locally on the device.

---

## What it does

Add any place by giving it a name, snapping a picture with your camera, and picking its location. You can grab your current GPS coordinates directly or pick a spot manually on an interactive map.

When a location is selected, the app reverse-geocodes the coordinates via OpenStreetMap's Nominatim service so you get a real street address instead of raw coordinates.

Photos are moved out of the temporary cache into the app's permanent document directory, and place details are stored in a local SQLite database (`places.db`). When the app boots up, previously saved places are automatically read from SQLite and displayed on the home screen.

---

## Screens

**Your Places (`places.dart`)** — the main screen (`ConsumerStatefulWidget`). On startup, a `FutureBuilder` loads saved places from the SQLite database while showing a loading spinner. Each entry in the list displays a photo thumbnail, place title, and formatted address. Tapping the `+` button in the app bar opens the add screen.

**Add a New Place (`add_place.dart`)** — a form with three required inputs:
- Title text field
- Camera photo capture (`image_input.dart`, tap to retake anytime)
- Location picker (`location_input.dart`) with **Current Location** (GPS) and **Select on Map** (manual picker), plus an inline map preview

Missing any of the three inputs triggers a snackbar warning.

**Map Screen (`map.dart`)** — full-screen interactive OpenStreetMap view powered by `flutter_map`.
- **Pick mode (`isSelecting: true`):** tap anywhere on the map to place a red marker, then tap the save icon in the app bar to confirm.
- **View mode (`isSelecting: false`):** read-only map centered on a saved place's location.

**Place Details (`place_details.dart`)** — full-screen view of the saved photo. A bottom overlay features a circular map preview (`CircleAvatar` + `ClipOval`) centered on the location. Tapping the circular map opens the full interactive map screen in view mode. The resolved address is displayed below.

---

## Tech stack

| What | Package |
|---|---|
| State management | `flutter_riverpod` |
| Local database | `sqflite` |
| File paths & permanent storage | `path` + `path_provider` |
| Maps & map tiles | `flutter_map` + `latlong2` (OpenStreetMap tiles) |
| Reverse geocoding | `http` (Nominatim API) |
| Device GPS | `location` + `geolocator` |
| Camera | `image_picker` |
| Fonts | `google_fonts` (Ubuntu Condensed + Lato) |
| IDs | `uuid` |

---

## Project layout

```
lib/
├── main.dart               # entry point, dark purple theme
├── Models/
│   └── place.dart          # Place and PlaceLocation data classes
├── Providers/
│   └── user_places.dart    # Riverpod notifier with SQLite database operations & file copy logic
├── Screens/
│   ├── places.dart         # home screen, handles SQLite loading on init
│   ├── add_place.dart      # add place form
│   ├── place_details.dart  # full photo view + circular map preview
│   └── map.dart            # interactive OpenStreetMap (pick or view mode)
└── Widgets/
    ├── image_input.dart    # camera trigger and photo preview
    ├── location_input.dart # GPS fetcher, map launcher, and Nominatim geocoder
    └── places_list.dart    # list tiles showing photo thumbnail, title, and address
```

---

## Running the app

Ensure Flutter is installed and configured on your machine:

```bash
flutter pub get
flutter run
```

### Permissions
- **Camera:** required when taking photos with `image_picker`.
- **Location:** required when using the "Current Location" button.
- The operating system prompts for these permissions at runtime on first use.

---

## Notes

- **Reverse Geocoding:** Nominatim requires a user-agent header, which is passed on each request. If offline or if the request times out, it falls back to raw latitude/longitude coordinates.
- **Map fallback:** Opening the map picker before any location is chosen defaults to `(37.422, -122.084)`.
- **Theme:** Dark purple theme configured globally in `main.dart`.
