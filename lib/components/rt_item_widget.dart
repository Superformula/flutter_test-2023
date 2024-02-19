import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/core/rt_colors.dart';
import 'package:restaurantour/core/rt_text_style.dart';
import 'package:restaurantour/models/restaurant.dart';

class RTItemWidget extends StatelessWidget {
  const RTItemWidget({
    super.key,
    required this.restaurant,
    required this.isFirstItem,
    this.onFinishNavigation,
    required this.imageNetwork,
    required this.openDetails,
  });
  final bool isFirstItem;
  final Restaurant restaurant;
  final VoidCallback? onFinishNavigation;
  final Function openDetails;
  final RTImageNetwork imageNetwork;

  double get rating => restaurant.rating ?? 0;
  String get heroImage => restaurant.heroImage;
  String get priceLabel => restaurant.price ?? '';
  List<Widget> get starRate => List.generate(rating > 5 ? 5 : rating.toInt(), (_) => SvgPicture.asset('assets/svg/star.svg'));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0).copyWith(top: isFirstItem ? 16 : 0),
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        elevation: 2,
        child: InkWell(
          onTap: () async {
            await openDetails();
            if (onFinishNavigation != null) onFinishNavigation!();
          },
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
                            color: RTColors.placeholder,
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
                                      color: restaurant.isOpen ? RTColors.open : RTColors.closed,
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
