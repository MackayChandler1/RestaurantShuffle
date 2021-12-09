import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_shuffle/pages/filter_screen.dart';
import 'dart:convert';
import 'package:restaurant_shuffle/models/restaurant.dart';
import 'dart:math';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_shuffle/globals.dart' as globals;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:restaurant_shuffle/pages/restaurant_details.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List _restaurantList = [];
  var filteredList = [];
  final Random _rnd = Random();
  var _index = 0;
  num clickNum = 0;

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
        child: filteredList.isEmpty
            ? Text("All restaurants are filtered out")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          text: filteredList[_index]['name'],
                          style: TextStyle(fontSize: 35.0, color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RestaurantDetails(
                                          restaurant: filteredList[_index])));
                            })),
                  Container(
                    height: 10,
                  ),
                  Text('${clickNum} restaurant(s) have been recommended')
                ],
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
      if (filteredList.isEmpty) {
        _index = 0;
      } else {
        _index = _rnd.nextInt(filteredList.length);
      }
      clickNum += 1;
    });
  }

  void navigateToFilter() {
    Navigator.of(context).pushNamed(FilterScreen.id).then((value) {
      filterList();
    });
  }

  void filterList() {
    filteredList = _restaurantList
        .where((r) =>
            (r["category"] == globals.category ||
                globals.category == "All Categories") &&
            r["milesRadius"] <= globals.miles &&
            r["pricePerMeal"] <= globals.price)
        .toList();
    setState(() {});
  }

  Widget _returnRandomRestaurant(
      BuildContext context, DocumentSnapshot document) {
    return Text(document['name']);
  }

  void getData() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('restaurants').get();
    _restaurantList = snapshot.docs.map((e) => e.data()).toList();
    filterList();
  }
}
