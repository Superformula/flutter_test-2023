import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantStatus extends StatelessWidget {
  final bool isOpenNow;
  const RestaurantStatus(this.isOpenNow, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          isOpenNow ? 'Open Now' : 'Closed',
          style: GoogleFonts.openSans(
            fontSize: 14.0,
            fontStyle: FontStyle.italic,
            height: 0.8,
          ),
        ),
        const SizedBox(width: 4.0),
        Icon(
          Icons.circle,
          color: isOpenNow ? Colors.green : Colors.red,
          size: 8.0,
          semanticLabel: 'Rating',
        )
      ],
    );
  }
}
