import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_shuffle/pages/filter_screen.dart';
import 'dart:convert';
import 'package:restaurant_shuffle/models/restaurant.dart';
import 'dart:math';
import 'dart:core';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _restaurantList = [];
  Random _rnd = Random();
  var _index = 0;

  @override
  void initState() {
    super.initState();
    readJson();
  }

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
          _restaurantList[_index].name,
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: shuffle,
        child: Icon(
          Icons.refresh,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/example_restaurants.json');
    var list = json
        .decode(response)['restaurants']
        .map((data) => Restaurant.fromJson(data))
        .toList();
    setState(() {
      _restaurantList = list;
      _index = _rnd.nextInt(_restaurantList.length);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void shuffle() {
    setState(() {
      this._index = _rnd.nextInt(_restaurantList.length);
    });
  }

  void navigateToFilter() {
    Navigator.of(context).pushNamed(FilterScreen.id);
  }
}
