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
  List<Widget> get starRate => List.generate(rating > 5 ? 5 : rating.toInt(), (_) => SvgPicture.asset('assets/svg/star.svg'));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<RTThemeExtension>()!;
    return Padding(
      padding: const EdgeInsets.all(12.0).copyWith(top: isFirstItem ? 16 : 0),
      child: Material(
        color: theme.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        elevation: 2,
        child: InkWell(
          onTap: openDetails,
          child: SizedBox(
            height: 104,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: SizedBox(
                      width: 88,
                      height: 88,
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
                  const SizedBox(width: 12),
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
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Container(
                                    width: 8,
                                    height: 8,
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
