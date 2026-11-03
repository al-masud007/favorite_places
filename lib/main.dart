import 'package:favorite_places/Screens/places.dart';
import 'package:flutter/material.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 102, 6, 147),
  surface: Color.fromARGB(255, 56, 50, 70),
);

ThemeData theme = ThemeData(
  colorScheme: colorScheme,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.onPrimaryContainer,
    foregroundColor: colorScheme.primaryContainer,
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: PlacesScreen());
  }
}
