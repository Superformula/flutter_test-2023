import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantCardPrice extends StatelessWidget {
  final String? price;
  const RestaurantCardPrice(this.price, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return price == null
        ? const SizedBox()
        : Text(
            price!,
            style: GoogleFonts.openSans(fontSize: 12.0),
          );
  }
}
