import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurantour/presentation/utils/style_util.dart';

class StarsWidget extends StatelessWidget {
  final double rating;

  const StarsWidget({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        rating.floor(),
        (index) => SvgPicture.asset('assets/svg/star.svg'),
      ),
    );
  }

  static large({required double rating}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(rating.toString(), style: StyleUtil.rating),
        Padding(
          padding: const EdgeInsets.only(left: 3, bottom: 7),
          child: SvgPicture.asset('assets/svg/star.svg'),
        ),
      ],
    );
  }
}
