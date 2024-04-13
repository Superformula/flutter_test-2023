import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantCardWidget extends StatelessWidget {
  Restaurant restaurant;
  RestaurantCardWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      color: Colors.red,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        color: Colors.green,
        height: size.height * 0.15,
        width: size.width * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.network(restaurant.heroImage),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    restaurant.name ?? "",
                    maxLines: 2,
                  ),
                  Text("\$\$ ${restaurant.displayCategory}"),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
