import 'package:flutter/material.dart';
import 'package:restaurantour/domain/entities/entities.dart';

class RestaurantHeroImageWidget extends StatelessWidget {
  const RestaurantHeroImageWidget({super.key, required this.restaurantEntity});

  final RestaurantEntity? restaurantEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: SizedBox(
        height: 361,
        child: Hero(
          tag: restaurantEntity?.heroImage ?? "",
          child: Image.network(
            restaurantEntity?.heroImage ?? "",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
