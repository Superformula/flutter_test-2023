import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              child: Image.network(
                'https://picsum.photos/250?image=9',
                height: 88,
                width: 88,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restaurant name goes here and wrap two lines',
                    style: GoogleFonts.lora(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '\$\$\$\$ Italian',
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const RatingStars(
                        starCount: 5,
                        starColor: Color(0xffFFB800),
                        valueLabelVisibility: false,
                        value: 5,
                        starSize: 12,
                        starSpacing: 0,
                      ),
                      const Spacer(),
                      Text(
                        'Open Now',
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.circle_rounded,
                        color: Color(0xff5CD313),
                        size: 12,
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
