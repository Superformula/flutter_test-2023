import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantCardName extends StatelessWidget {
  final String? title;
  const RestaurantCardName(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "--------",
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.lora(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
