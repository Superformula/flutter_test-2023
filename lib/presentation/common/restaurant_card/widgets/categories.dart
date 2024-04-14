import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/data/models/restaurant.dart';

class RestaurantCardCategories extends StatelessWidget {
  final List<Category>? categories;
  const RestaurantCardCategories(this.categories, {Key? key}) : super(key: key);

  String getCategoriesTextList() {
    if (categories == null) return "";

    String listString = categories!
        .take(2)
        .map((category) => category.title ?? category.alias ?? "")
        .join(', ');

    if (categories!.length > 2) listString = '$listString and others.';

    return listString;
  }

  @override
  Widget build(BuildContext context) {
    if (categories == null) {
      return const SizedBox();
    } else {
      return Text(
        getCategoriesTextList(),
        style: GoogleFonts.openSans(fontSize: 12.0),
      );
    }
  }
}
