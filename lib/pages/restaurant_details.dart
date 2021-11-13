import 'package:flutter/material.dart';

class RestauarantDetailsScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _RestauarantDetailsScreen createState() => _RestauarantDetailsScreen();
}

class _RestauarantDetailsScreen extends State<RestauarantDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Shuffle - Details'),
      ),
    );
  }
}
