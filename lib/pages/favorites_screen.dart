import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _FavoritesScreen createState() => _FavoritesScreen();
}

class _FavoritesScreen extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Shuffle - Favorites'),
      ),
    );
  }
}
