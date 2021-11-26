import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_shuffle/pages/filter_screen.dart';
import 'dart:convert';
import 'package:restaurant_shuffle/models/restaurant.dart';
import 'dart:math';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List _restaurantList = [];
  final Random _rnd = Random();
  var _index = 0;

  @override
  void initState() {
    super.initState();
    getData();
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
        child: _restaurantList.isEmpty
            ? Text("Loading...")
            : Text(
                _restaurantList[_index]['name'],
                style: TextStyle(fontSize: 30),
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

  @override
  void dispose() {
    super.dispose();
  }

  void shuffle() {
    setState(() {
      _index = _rnd.nextInt(_restaurantList.length);
    });
  }

  void navigateToFilter() {
    Navigator.of(context).pushNamed(FilterScreen.id);
  }

  Widget _returnRandomRestaurant(
      BuildContext context, DocumentSnapshot document) {
    return Text(document['name']);
  }

  void getData() async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .get()
        .then((QuerySnapshot querysnapshot) {
      setState(() {
        _restaurantList = querysnapshot.docs;
      });
    });
    debugPrint(_restaurantList.length.toString());
  }
}
