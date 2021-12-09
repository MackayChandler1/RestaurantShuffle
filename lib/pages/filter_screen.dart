import 'package:flutter/material.dart';
import 'package:restaurant_shuffle/globals.dart' as globals;

class FilterScreen extends StatefulWidget {
  static const String id = 'filter_screen';
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

String category = globals.category;
double miles = globals.miles;
double price = globals.price;
var items = ["All Categories", "Burger", "Mexican", "Italian", "Sandwich"];

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(children: [
        SizedBox(height: 20),
        Text(
          'Filters',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 42),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 350.0,
                child: DropdownButton<String>(
                  value: category,
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      globals.category = newValue!;
                      category = newValue;
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
        SizedBox(height: 20),
        Text(
          'Mile Radius',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 22),
        ),
        SizedBox(height: 10),
        Slider(
            min: 5,
            max: 25,
            value: miles,
            onChanged: (newMiles) {
              setState(() => {globals.miles = newMiles, miles = newMiles});
            },
            divisions: 4,
            label: "$miles miles or less"),
        SizedBox(height: 20),
        Text(
          'Price per Meal',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 22),
        ),
        SizedBox(height: 10),
        Slider(
            min: 5,
            max: 25,
            value: price,
            onChanged: (newPrice) {
              setState(() => {globals.price = newPrice, price = newPrice});
            },
            divisions: 4,
            label: "$price per Meal and less")
      ]),
    );
  }
}
