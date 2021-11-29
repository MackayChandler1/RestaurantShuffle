import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_shuffle/models/restaurant.dart';

class FavoritesScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _FavoritesScreen createState() => _FavoritesScreen();
}

class _FavoritesScreen extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _favoritesStream = FirebaseFirestore.instance
        .collection('restaurants')
        .where('favorite', isEqualTo: true)
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _favoritesStream,
          builder:
              ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Loading...'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('No Favorites'));
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  leading: FlutterLogo(
                    size: 30,
                  ),
                  title: Center(
                    child: Text(
                      data['name'],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.star),
                    color: Colors.yellow,
                    iconSize: 30,
                    onPressed: () => _star(data['id']),
                  ),
                );
              }).toList(),
            );
          }),
        ));
  }

  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  void _star(num id) async {
    num docId = id + 1;
    await restaurants
        .doc(docId.toString())
        .update({'favorite': false})
        .then((value) => print("Restaurant Updated"))
        .catchError((error) => print("Failed to update restaurant: $error"));
    ;
  }
}
