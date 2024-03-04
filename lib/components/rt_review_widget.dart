import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/theme/theme.dart';

class RTReviewWidget extends StatelessWidget {
  const RTReviewWidget({super.key, required this.review, required this.isFirstItem, required this.imageNetwork});
  final bool isFirstItem;
  final ReviewDto review;
  final RTImageNetwork imageNetwork;
  int get rating => review.rating ?? 0;
  List<Widget> get starRate => List.generate(rating > 5 ? 5 : rating.toInt(), (_) => SvgPicture.asset('assets/svg/star.svg'));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<RTThemeExtension>()!;

    return Column(
      children: [
        if (!isFirstItem) Divider(color: theme.dividerLineColor),
        Padding(
          padding: EdgeInsets.symmetric(vertical: RTSizesType.xl.size),
          child: SizedBox(
            height: RTSizesType.xxxgg.size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: starRate),
                RTSizesType.s.spacer,
                Text(
                  review.text ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: RTTextStyle.body1(),
                ),
                RTSizesType.s.spacer,
                Row(
                  children: [
                    SizedBox(
                      width: RTSizesType.xg.size,
                      height: RTSizesType.xg.size,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(RTSizesType.xxxxgg.size),
                        child: imageNetwork.build(
                          location: review.user?.imageUrl ?? '',
                          errorWidget: Container(
                            color: theme.placeholderColor,
                            child: const Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                    RTSizesType.s.spacer,
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
