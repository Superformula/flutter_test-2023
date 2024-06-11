import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/pages/restaurants_page.dart';
import 'package:restaurantour/presentation/widgets/restaurant_rating_widget.dart';

import '../../models/restaurant.dart';
import '../../utils/typography/restaurantour_text_styles.dart';

class RestaurantCardWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCardWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          bottom: 12.0,
        ),
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RestaurantPage(
                restaurant: restaurant,
              ),
            ),
          ),
          child: Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 104,
              width: 351,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 88,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          restaurant.heroImage,
                        ),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name ?? '',
                          style: RestaurantourTextStyles.subtitle1Lora,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        Text(
                          '${restaurant.price} ${restaurant.categories!.first.title ?? ''}',
                          style: RestaurantourTextStyles.caption,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            StarRating(
                              color: const Color(0xFFFFB800),
                              rating: restaurant.rating ?? 0.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  restaurant.isOpen ? 'Open now' : 'Closed',
                                  style: RestaurantourTextStyles.overline,
                                ),
                                const SizedBox(width: 8.0),
                                Container(
                                  height: 8.0,
                                  width: 8.0,
                                  decoration: BoxDecoration(
                                    color: restaurant.isOpen
                                        ? Colors.green
                                        : Colors.red,
                                    shape: BoxShape.circle,
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
