# Favorite Places

A Flutter app to save the places you visit — photo, pinpoint location, and human-readable address all stored locally.

---

## What it does

Add any place by giving it a name, taking a picture with your camera, and pinning its location. You can grab your current GPS coordinates or pick a spot manually on an interactive map.

When a location is picked, the app reverse-geocodes the coordinates through OpenStreetMap's Nominatim service so you get an actual readable address, not just raw latitude and longitude.

Photos are copied out of the temporary cache into the app's document storage, and place data is saved into a local SQLite database (`places.db`).

---

## Screens

**Your Places** — the home screen. Shows your saved places in a list with image thumbnails, place names, and resolved street addresses. Tapping the `+` button in the app bar opens the add screen.

**Add a New Place** — a form with three required inputs:
- Title field
- Camera photo picker (tap the preview anytime to retake)
- Location input with two buttons: **Current Location** (GPS) and **Select on Map** (manual map picker), plus an inline mini-map preview

All fields must be filled before saving; otherwise, a snackbar prompts what's missing.

**Map Screen** — full-screen OpenStreetMap view powered by `flutter_map`.
- **Pick mode (`isSelecting: true`):** tap anywhere on the map to move the marker, then hit the save icon in the app bar to confirm.
- **View mode (`isSelecting: false`):** read-only view centered on an already saved place.

**Place Details** — shows the saved photo full-screen. At the bottom, there is an overlay with a circular map snapshot centered on the place's coordinates. Tapping the circle opens the full interactive map view, and the full address is listed right below.

---

## Tech stack

| What | Package |
|---|---|
| State management | `flutter_riverpod` |
| Local database | `sqflite` |
| File paths & app storage | `path` + `path_provider` |
| Maps & tiles | `flutter_map` + `latlong2` (OpenStreetMap tiles) |
| Reverse geocoding | `http` (Nominatim OpenStreetMap API) |
| Device GPS | `location` + `geolocator` |
| Camera capture | `image_picker` |
| Fonts | `google_fonts` (Ubuntu Condensed + Lato) |
| Unique IDs | `uuid` |

---

## Project layout

```
lib/
├── main.dart               # entry point, dark purple theme definition
├── Models/
│   └── place.dart          # Place and PlaceLocation models
├── Providers/
│   └── user_places.dart    # Riverpod notifier with SQLite persistence and file copying
├── Screens/
│   ├── places.dart         # main list screen
│   ├── add_place.dart      # add place form
│   ├── place_details.dart  # full photo view with circular map preview
│   └── map.dart            # interactive OpenStreetMap (pick or view)
└── Widgets/
    ├── image_input.dart    # camera trigger and photo preview box
    ├── location_input.dart # GPS fetcher, map launcher, and Nominatim geocoder
    └── places_list.dart    # list tiles showing photo thumbnail, title, and address
```

---

## Running the app

Ensure Flutter is set up on your machine, then run:

```bash
flutter pub get
flutter run
```

### Permissions
- **Camera:** required when taking photos via `image_picker`.
- **Location:** required when using the "Current Location" button.
- The operating system will request these permissions at runtime when you first trigger those actions.

---

## Notes

- **Reverse Geocoding:** Reverse geocoding uses OpenStreetMap's Nominatim endpoint with a custom user-agent header. If offline or if the request fails, it falls back to raw coordinates.
- **Map fallback:** If you open the map picker before any location is selected, it defaults to `(37.422, -122.084)`.
- **Theme:** Dark purple theme configured globally in `main.dart`.
