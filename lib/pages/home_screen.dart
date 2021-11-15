import 'package:flutter/material.dart';
import 'package:restaurant_shuffle/pages/filter_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String resturantName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Shuffle'),
        actions: [
          IconButton(
            onPressed: navigateToFilter,
            icon: Icon(Icons.settings),
            tooltip: 'Filters',
          )
        ],
      ),
      body: Center(
        child: Text(
          "Example Restaurant",
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: example,
        child: Icon(
          Icons.refresh,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Delete when implementation is finished
  void example() {
    debugPrint("Shuffle");
  }

  void navigateToFilter() {
    Navigator.of(context).pushNamed(FilterScreen.id);
  }
}
