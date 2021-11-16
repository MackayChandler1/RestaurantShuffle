import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_shuffle/models/restaurant.dart';

class FavoritesScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _FavoritesScreen createState() => _FavoritesScreen();
}

class _FavoritesScreen extends State<FavoritesScreen> {
  List _favoriteList = [];

  Future<void> getData() async {
    List restaurantList = [];
    final String response =
        await rootBundle.loadString('assets/example_restaurants.json');
    var list = json
        .decode(response)['restaurants']
        .map((data) => Restaurant.fromJson(data))
        .toList();
    for (Restaurant res in list) {
      debugPrint(res.name);
      restaurantList.add(res);
    }
    setState(() {
      _favoriteList = restaurantList;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Shuffle - Favorites'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Container(
          height: 50,
          child: Row(
            children: [
              Text('${_favoriteList[index].name}'),
              Container(),
              IconButton(onPressed: star, icon: Icon(Icons.star_outline))
            ],
          ),
        );
      }),
    );
  }

  void star() {
    debugPrint("Press Star");
  }
}
