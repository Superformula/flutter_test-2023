import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/widgets/restaurant_attributes.dart';
import 'package:superformula_flutter_test/widgets/restaurant_status_widget.dart';

import '../models/restaurant.dart';
import '../widgets/user_reviews_list.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const String id = 'restaurant_detail_screen';
  final Restaurant restaurant;
  const RestaurantDetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        title: Text(restaurant.name ?? "N/A", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {},
            color: Colors.black,
            icon: Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: restaurant.id.toString(),
              child: Image.network(
                restaurant.photos?[0] ?? "",
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RestaurantAttributes(restaurant: restaurant),
                      RestaurantStatusWidget(status: restaurant.hours?[0].restaurantStatus ?? RestaurantStatus.closed),
                    ],
                  ),
                  Divider(height: 42),
                  Text("Address"),
                  SizedBox(height: 12),
                  Text(
                    restaurant.location?.formattedAddress ?? "N/A",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Divider(height: 42),
                  Text("Overall Rating"),
                  SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        (restaurant.rating ?? "N/A").toString(),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      if (restaurant.rating != null) Icon(Icons.star, size: 14, color: Colors.yellow[700]),
                    ],
                  ),
                  Divider(height: 42),
                  Text("${restaurant.reviews?.length ?? 0} Reviews"),
                  SizedBox(height: 12),
                  UserReviewsList(reviews: restaurant.reviews),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
