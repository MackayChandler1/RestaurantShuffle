import 'dart:core';

class Restaurant {
  final String name;
  final String address;
  final String city;
  final String state;
  final String postal_code;
  final num stars;
  final num review_count;
  final bool is_open;

  Restaurant(this.name, this.address, this.city, this.state, this.postal_code,
      this.stars, this.review_count, this.is_open);
  Restaurant.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'],
        city = json['city'],
        state = json['state'],
        postal_code = json['postal_code'],
        stars = json['stars'],
        review_count = json['review_count'],
        is_open = json['is_open'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'city': city,
        'state': state,
        'postal_code': postal_code,
        'stars': stars,
        'review_count': review_count,
        'is_open': is_open,
      };
}
