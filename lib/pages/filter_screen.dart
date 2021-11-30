import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

String dropdownValue = "burger";

var items = ["burger", "mexican"];

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Shuffle - Filter'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 300.0,
              child: DropdownButton<String>(
                value: dropdownValue,
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }
}
