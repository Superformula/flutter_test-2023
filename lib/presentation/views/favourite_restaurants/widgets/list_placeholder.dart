import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavListPlaceholder extends StatelessWidget {
  const FavListPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.favorite_border,
          color: Colors.black54,
          size: 54.0,
        ),
        const SizedBox(height: 20.0),
        Text(
          "You don't have any favorite restaurants yet",
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            fontSize: 18.0,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Mark a restaurant as a favorite \nso it appears on the list",
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            fontSize: 14.0,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
