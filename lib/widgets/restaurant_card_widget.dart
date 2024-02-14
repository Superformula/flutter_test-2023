import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restaurantour/common/constants.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantCardWidget extends StatelessWidget {
  final int restaurantIndex;

  final Restaurant restaurant;

  const RestaurantCardWidget({
    Key? key,
    required this.restaurantIndex,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 350,
        height: 135,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Hero(
                tag: 'hero-restaurant-image-$restaurantIndex',
                child: Image.network(
                  restaurant.heroImage,
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.name!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '\$${restaurant.price}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20.0,
                              );
                            }),
                          ),
                          restaurant.isOpen
                              ? Row(
                                  children: <Widget>[
                                    const Text(
                                      Constants.openNow,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: <Widget>[
                                    const Text(
                                      Constants.closed,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ],
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
