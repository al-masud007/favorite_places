import 'package:flutter/material.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(
                MaterialPageRoute(
                  builder: (ctx) => const Text('Add a new place'),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
