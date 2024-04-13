import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';
import 'package:restaurantour/modules/home/ui/details_restaurant_page.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_theme.dart';
import 'circular_progress_widget.dart';

class CardRestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurantWidget({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsRestaurantPage(restaurant: restaurant),
        ),
      ),
      child: Container(
        height: 104,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: restaurant.heroImage,
                height: 88,
                width: 88,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) => const CircularProgressWidget(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    restaurant.name ?? '',
                    style: AppTextStyle.black16w600.copyWith(fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Spacer(),
                  Text(restaurant.displayCategory, style: AppTextStyle.black12w400OpenSans),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ...List.generate(
                        restaurant.rating?.toInt() ?? 0,
                        (index) => const Icon(Icons.star, color: AppTheme.yellowColor, size: 16),
                      ).toList(),
                      const Spacer(),
                      Text(
                        restaurant.isOpen ? 'Open Now' : 'Closed',
                        style: AppTextStyle.black12w400OpenSans.copyWith(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 3),
                        child: CircleAvatar(
                          backgroundColor: restaurant.isOpen ? AppTheme.greenColor : AppTheme.redColor,
                          radius: 4,
                        ),
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
