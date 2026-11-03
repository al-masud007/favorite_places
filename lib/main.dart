import 'package:favorite_places/Screens/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 102, 6, 147),
  surface: Color.fromARGB(255, 56, 50, 70),
);

final theme = ThemeData().copyWith(
  colorScheme: colorScheme,
  scaffoldBackgroundColor: colorScheme.surface,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    bodyMedium: GoogleFonts.ubuntuCondensed(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: GoogleFonts.ubuntuCondensed(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.ubuntuCondensed(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: PlacesScreen());
  }
}
