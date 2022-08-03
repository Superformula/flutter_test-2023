import 'package:flutter/material.dart';

import '../../models/restaurant.dart';
import 'restaurant_is_open_widget.dart';
import 'restaurant_price_and_category_widget.dart';
import 'rating_widget.dart';

class RestaurantListTile extends StatelessWidget {
  const RestaurantListTile({
    required this.restaurant,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Restaurant restaurant;
  final void Function() onTap;

  static const restaurantNameStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Imperial Roman',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    wordSpacing: 1,
    height: 1.5,
  );

  @override
  Widget build(BuildContext context) {
    final img = Padding(
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxHeight,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(restaurant.heroImage),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );

    final restaurantName = Align(
      alignment: Alignment.topLeft,
      child: Text(
        restaurant.name ?? '',
        style: restaurantNameStyle,
        maxLines: 2,
      ),
    );

    final restaurantPriceAndCategory = Align(
      alignment: const Alignment(-1, 0.45),
      child: RestaurantPriceAndCategoryWidget(restaurant),
    );

    final restaurantEvaluationAndIsOpenOrClosed = Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingWidget.simple(restaurant.rating),
          RestaurantIsOpenWidget(restaurant),
        ],
      ),
    );

    final restaurantInformation = Padding(
      padding: const EdgeInsets.fromLTRB(0, 9.3, 10, 5.15),
      child: Stack(
        children: [
          restaurantName,
          restaurantPriceAndCategory,
          restaurantEvaluationAndIsOpenOrClosed,
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 9.75,
        vertical: 2,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shadowColor: Colors.grey.shade200,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.75),
          ),
          child: SizedBox(
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                img,
                Expanded(child: restaurantInformation),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
