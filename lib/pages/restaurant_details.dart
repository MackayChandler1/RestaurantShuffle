import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestauarantDetailsScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _RestauarantDetailsScreen createState() => _RestauarantDetailsScreen();
}

class _RestauarantDetailsScreen extends State<RestauarantDetailsScreen> {
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
                  onPressed: () => _favorite(data['id']),
                ),
              );
            }).toList(),
          );
        }),
      ),
    );
  }

  void _favorite(num id) {
    num docId = id + 1;
  }
}
