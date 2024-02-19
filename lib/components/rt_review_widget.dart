import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/core/rt_colors.dart';
import 'package:restaurantour/core/rt_text_style.dart';
import 'package:restaurantour/models/dto.dart';

class RTReviewWidget extends StatelessWidget {
  const RTReviewWidget({super.key, required this.review, required this.isFirstItem, required this.imageNetwork});
  final bool isFirstItem;
  final ReviewDto review;
  final RTImageNetwork imageNetwork;
  int get rating => review.rating ?? 0;
  List<Widget> get starRate => List.generate(rating > 5 ? 5 : rating.toInt(), (_) => SvgPicture.asset('assets/svg/star.svg'));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirstItem) const Divider(color: RTColors.dividerLine),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: starRate),
                const SizedBox(height: 8),
                Text(
                  review.text ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: RTTextStyle.body1(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: imageNetwork.build(
                          location: review.user?.imageUrl ?? '',
                          errorWidget: Container(
                            color: RTColors.placeholder,
                            child: const Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      review.user?.name ?? '',
                      style: RTTextStyle.caption(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
