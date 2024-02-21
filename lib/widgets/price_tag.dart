import 'package:flutter/material.dart';
import 'package:restaurantour/resources/resources_exports.dart';

class PriceTag extends StatelessWidget {
  final String? price;
  final String? category;
  final TextStyle? style;
  const PriceTag({
    Key? key,
    this.price,
    this.category,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: AppSize.size4.w),
        Text(price ?? '', style: style),
        SizedBox(width: AppSize.size4.w),
        Text(category ?? '', style: style),
      ],
    );
  }
}
