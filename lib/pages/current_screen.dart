import 'package:flutter/material.dart';
import 'package:restaurant_shuffle/pages/favorites_screen.dart';
import 'dart:core';
import 'package:restaurant_shuffle/pages/home_screen.dart';
import 'package:restaurant_shuffle/pages/restaurant_list.dart';

class CurrentScreen extends StatefulWidget {
  static const String id = 'current_screen';
  @override
  _CurrentScreenState createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  var _pages = [
    HomeScreen(),
    FavoritesScreen(),
    RestauarantListScreen(),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (i) {
          setState(() {
            currentPage = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
            backgroundColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
