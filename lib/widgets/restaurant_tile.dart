import 'dart:math';

import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/widgets/restaurant_attributes.dart';

import '../models/restaurant.dart';
import '../screens/restaurant_detail_screen.dart';
import 'restaurant_status_widget.dart';
import 'stars_widget.dart';

class RestaurantTile extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantTile({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<RestaurantTile> createState() => _RestaurantTileState();
}

class _RestaurantTileState extends State<RestaurantTile> {
  final int heroTag = Random().nextInt(10000);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetailScreen(restaurant: widget.restaurant, heroTag: heroTag))),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Hero(
                      tag: heroTag,
                      child: Image.network(widget.restaurant.photos?[0] ?? "", fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurant.name ?? "N/A",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    RestaurantAttributes(restaurant: widget.restaurant),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StarsWidget(starCount: widget.restaurant.rating?.round() ?? 0),
                        RestaurantStatusWidget(status: widget.restaurant.hours?[0].restaurantStatus ?? RestaurantStatus.closed),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
