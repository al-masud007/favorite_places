import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Place Details')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Place details will be shown here.'),
      ),
    );
  }
}
