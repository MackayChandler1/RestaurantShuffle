import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_shuffle/pages/restaurant_details.dart';

class RestauarantListScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _RestauarantListScreen createState() => _RestauarantListScreen();
}

class _RestauarantListScreen extends State<RestauarantListScreen> {
  final Stream<QuerySnapshot> _restaurantsStream =
      FirebaseFirestore.instance.collection('restaurants').snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _restaurantsStream,
        builder:
            ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading...'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No Restaurants'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: RichText(
                  text: TextSpan(
                      text: data['name'],
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RestaurantDetails(restaurant: data)));
                        }),
                ),
                trailing: IconButton(
                  icon: data['favorite']
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border_outlined),
                  color: data['favorite'] ? Colors.yellow : Colors.black,
                  iconSize: 30,
                  onPressed: data['favorite']
                      ? () => _unfavorite(data['id'])
                      : () => _favorite(data['id']),
                ),
              );
            }).toList(),
          );
        }),
      ),
    );
  }

  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  void _favorite(num id) async {
    num docId = id + 1;
    await restaurants
        .doc(docId.toString())
        .update({'favorite': true})
        .then((value) => print("Restaurant Updated"))
        .catchError((error) => print("Failed to update restaurant: $error"));
  }

  void _unfavorite(num id) async {
    num docId = id + 1;
    await restaurants
        .doc(docId.toString())
        .update({'favorite': false})
        .then((value) => print("Restaurant Updated"))
        .catchError((error) => print("Failed to update restaurant: $error"));
  }
}
