import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/common/network_hero/network_image_hero.dart';
import 'package:restaurantour/presentation/common/restaurant_status/restaurant_status.dart';

class RestaurantPage extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantPage(this.restaurant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          restaurant.name ?? "",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lora(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 361.0,
              width: double.infinity,
              child: NetworkImageHero(
                imageLink: restaurant.heroImage,
                heroId: restaurant.id ?? restaurant.name ?? "",
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${restaurant.price} ${restaurant.displayCategory}",
                        style: GoogleFonts.openSans(fontSize: 12.0),
                      ),
                      RestaurantStatus(restaurant.isOpen)
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const Divider(color: Colors.black26),
                  const SizedBox(height: 24.0),
                  Text(
                    "Address",
                    style: GoogleFonts.openSans(fontSize: 12.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    restaurant.location?.formattedAddress ?? "",
                    style: GoogleFonts.openSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Divider(color: Colors.black26),
                  const SizedBox(height: 24.0),
                  Text(
                    "Overall Rating",
                    style: GoogleFonts.openSans(fontSize: 12.0),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        restaurant.rating.toString(),
                        style: GoogleFonts.lora(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber[800],
                        size: 14.0,
                        semanticLabel: 'Rating',
                      )
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const Divider(color: Colors.black26),
                  const SizedBox(height: 24.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
