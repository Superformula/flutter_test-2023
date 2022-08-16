import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/widgets/restaurant_attributes.dart';
import 'package:superformula_flutter_test/widgets/restaurant_status_widget.dart';

import '../models/restaurant.dart';
import '../widgets/user_reviews_list.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const String id = 'restaurant_detail_screen';
  final Restaurant? restaurant;
  const RestaurantDetailScreen({Key? key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant?.name ?? "N/A"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 200, color: Colors.blueGrey),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RestaurantAttributes(),
                      RestaurantStatusWidget(status: RestaurantStatus.open),
                    ],
                  ),
                  Divider(height: 42),
                  Text("Address"),
                  SizedBox(height: 12),
                  Text(
                    "102 Lakeside Ave \nSeattle, WA 98122",
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
                        "4.6",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.star, size: 14, color: Colors.yellow[700]),
                    ],
                  ),
                  Divider(height: 42),
                  Text("42 Reviews"),
                  SizedBox(height: 12),
                  UserReviewsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
