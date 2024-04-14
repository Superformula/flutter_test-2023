import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/common/restaurant_status/restaurant_status.dart';
import 'package:restaurantour/presentation/views/restaurant/widgets/spaced_divider.dart';

class RestaurantDetails extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetails(this.restaurant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              RestaurantStatus(restaurant.isOpen),
            ],
          ),
          const SpacedDivider(),
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
          const SpacedDivider(),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
