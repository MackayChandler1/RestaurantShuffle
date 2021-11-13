import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Shuffle - Filter'),
      ),
    );
  }
}
