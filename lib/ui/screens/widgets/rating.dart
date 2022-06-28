import 'package:flutter/material.dart';
import 'package:restaurantour/ui/theme/app_color.dart';

class Rating extends StatelessWidget {
  final double? rating;

  const Rating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rating != null) {
      List<Widget> children = [];
      for (var i = 0; i < rating! ~/ 1; i++) {
        children.add(
          const Icon(Icons.star, color: AppColor.star, size: 12.0),
        );
      }
      if (rating! % 1 == 0.5) {
        children
            .add(const Icon(Icons.star_half, color: AppColor.star, size: 12.0));
      }

      return Row(children: children);
    } else {
      return const SizedBox();
    }
  }
}
