import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Shuffle - Profile'),
      ),
    );
  }
}
