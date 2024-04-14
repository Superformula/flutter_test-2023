import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/common/network_hero/network_image_hero.dart';

class RestaurantCardImage extends StatelessWidget {
  final String imageLink;
  final String heroId;
  const RestaurantCardImage(
    this.imageLink, {
    Key? key,
    required this.heroId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88.0,
      height: 88.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: NetworkImageHero(
          imageLink: imageLink,
          heroId: heroId,
        ),
      ),
    );
  }
}
