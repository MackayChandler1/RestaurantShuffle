import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:maps_launcher/maps_launcher.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({Key? key, required this.restaurant})
      : super(key: key);

  final Map<String, dynamic> restaurant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        elevation: 0,
      ),
      body: Body(data: restaurant),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemImage(imgStr: data['imgURL']),
        Expanded(child: ItemInfo(data: data))
      ],
    );
  }
}

class ItemImage extends StatelessWidget {
  const ItemImage({Key? key, required this.imgStr}) : super(key: key);
  final String imgStr;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.network(imgStr,
        height: size.height * 0.25, width: double.infinity, fit: BoxFit.fill);
  }
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            data['name'],
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            RatingBar.builder(
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                debugPrint("Updated");
                              },
                              initialRating: data['stars'],
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                              itemSize: 30,
                            ),
                            Text('${data['review_count']} reviews')
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '\$${data['pricePerMeal']}  | ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text('${data['category']} | ',
                                style: TextStyle(fontSize: 20)),
                            data['is_open']
                                ? Text(
                                    'is open',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 20),
                                  )
                                : Text('is closed',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20)),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                              text: TextSpan(
                                  text:
                                      '${data['address']}, ${data['city']}, ${data['state']} ${data['postal_code']}',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => MapsLauncher.launchQuery(
                                        '${data['address']}, ${data['city']}, ${data['state']} ${data['postal_code']}, USA'),
                                  style: TextStyle(color: Colors.blue))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(data['description'])
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
