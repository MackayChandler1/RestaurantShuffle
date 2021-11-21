import 'package:flutter/material.dart';
import 'package:restaurant_shuffle/RestaurantShuffle.dart';
import 'package:restaurant_shuffle/pages/filter_screen.dart';
import 'pages/current_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw ErrorWidget(snapshot);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return RestaurantShuffle();
          }
          return CircularProgressIndicator();
        });
  }
}
