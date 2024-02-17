import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurantour/core/rt_colors.dart';
import 'package:restaurantour/core/text_style.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantItemWidget extends StatelessWidget {
  const RestaurantItemWidget({super.key, required this.restaurant, required this.isFirstItem});
  final bool isFirstItem;
  final Restaurant restaurant;

  double get rating => restaurant.rating ?? 0;
  String get heroImage => restaurant.heroImage;
  String get priceLabel => restaurant.price ?? '';
  List<Widget> get starRate => List.generate(rating > 5 ? 5 : rating.toInt(), (_) => SvgPicture.asset('assets/svg/star.svg'));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0).copyWith(top: isFirstItem ? 16 : 0),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        elevation: 2,
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
                    child: Image.network(
                      fit: BoxFit.cover,
                      heroImage,
                      errorBuilder: (_, __, ___) => Container(
                        color: RTColors.placeholder,
                        child: const Icon(Icons.error_outline),
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
                          style: RTTextStyle.subtitle1(color: RTColors.defaultText),
                        ),
                      ),
                      Text(
                        '$priceLabel ${restaurant.displayCategory}',
                        style: RTTextStyle.caption(color: RTColors.defaultText),
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
                                style: RTTextStyle.overline(color: RTColors.defaultText),
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
    );
  }
}
