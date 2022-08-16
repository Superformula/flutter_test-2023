import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';
import 'package:superformula_flutter_test/models/restaurant_status.dart';
import 'package:superformula_flutter_test/widgets/restaurant/restaurant_address.dart';
import 'package:superformula_flutter_test/widgets/restaurant/restaurant_attributes.dart';
import 'package:superformula_flutter_test/widgets/restaurant/restaurant_detail_appbar.dart';
import 'package:superformula_flutter_test/widgets/restaurant/restaurant_ratings.dart';
import 'package:superformula_flutter_test/widgets/restaurant/restaurant_status_widget.dart';
import 'package:superformula_flutter_test/widgets/restaurant/user_reviews_list.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const String id = 'restaurant_detail_screen';
  final Restaurant restaurant;
  final int heroTag;
  const RestaurantDetailScreen({Key? key, required this.restaurant, required this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RestaurantDetailAppBar(restaurant: restaurant),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: heroTag,
              child: Image.network(restaurant.photos?[0] ?? "", height: 350, fit: BoxFit.cover),
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
                  RestaurantAddress(restaurant: restaurant),
                  Divider(height: 42),
                  RestaurantRatings(restaurant: restaurant),
                  Divider(height: 42),
                  UserReviewsList(restaurant: restaurant),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
