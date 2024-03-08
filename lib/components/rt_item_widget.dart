import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/theme/theme.dart';

class RTItemWidget extends StatelessWidget {
  const RTItemWidget({
    super.key,
    required this.restaurant,
    required this.isFirstItem,
    required this.imageNetwork,
    required this.openDetails,
  });
  final bool isFirstItem;
  final RestaurantDto restaurant;
  final Function() openDetails;
  final RTImageNetwork imageNetwork;

  double get rating => restaurant.rating ?? 0;
  String get heroImage => restaurant.heroImage;
  String get priceLabel => restaurant.price ?? '';
  List<Widget> get starRate => List.generate(rating > 5 ? 5 : rating.toInt(), (_) => SvgPicture.asset(Assets.svg.star));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<RTThemeExtension>()!;
    return Padding(
      padding: EdgeInsets.all(RTSizesType.m.size).copyWith(top: isFirstItem ? RTSizesType.xl.size : 0),
      child: Material(
        color: theme.whiteColor,
        borderRadius: BorderRadius.all(RTSizesType.s.radius),
        elevation: RTSizesType.xxxs.size,
        child: InkWell(
          onTap: openDetails,
          child: SizedBox(
            height: RTSizesType.xgg.size,
            child: Padding(
              padding: EdgeInsets.all(RTSizesType.s.size),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(RTSizesType.s.radius),
                    child: SizedBox(
                      width: RTSizesType.gg.size,
                      height: RTSizesType.gg.size,
                      child: Hero(
                        tag: restaurant.name ?? '',
                        child: imageNetwork.build(
                          location: heroImage,
                          errorWidget: Container(
                            color: theme.placeholderColor,
                            child: const Icon(Icons.image_not_supported_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),
                  RTSizesType.m.spacer,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            restaurant.name ?? '',
                            maxLines: 2,
                            style: RTTextStyle.subtitle1(),
                          ),
                        ),
                        Text(
                          '$priceLabel ${restaurant.displayCategory}',
                          style: RTTextStyle.caption(),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: starRate),
                            Row(
                              children: [
                                Text(
                                  restaurant.isOpen
                                      ? AppLocalizations.of(context)!.restaurantListAllRestaurantsTabOpenNow
                                      : AppLocalizations.of(context)!.restaurantListAllRestaurantsTabClosed,
                                  style: RTTextStyle.overline(),
                                ),
                                RTSizesType.s.spacer,
                                Padding(
                                  padding: EdgeInsets.only(top: RTSizesType.xxxs.size),
                                  child: Container(
                                    width: RTSizesType.s.size,
                                    height: RTSizesType.s.size,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: restaurant.isOpen ? theme.openColor : theme.closedColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
