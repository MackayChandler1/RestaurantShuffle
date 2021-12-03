import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
        ItemImage(
            imgStr:
                'https://www.incimages.com/uploaded_files/image/1920x1080/getty_1187117706_2000133320009280260_423297.jpg'),
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
                        Text(
                          data['name'],
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SmoothStarRating(
                              borderColor: Colors.amber,
                              rating: data['rating'],
                            )
                          ],
                        )
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
