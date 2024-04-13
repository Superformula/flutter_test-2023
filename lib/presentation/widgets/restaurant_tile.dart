import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurantour/data/models/restaurant.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantTile({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 104),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Image.network(
            restaurant.heroImage,
            frameBuilder: (_, child, __, ___) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: child,
              );
            },
            width: 88,
            height: 88,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    restaurant.name!,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Lora',
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      restaurant.price.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.displayCategory,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    for (var i = 0; i < restaurant.rating!.floor(); i++)
                      SvgPicture.asset('assets/svg/star.svg'),
                    Expanded(child: Container()),
                    Text(
                      restaurant.isOpen ? 'Open Now' : 'Closed',
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(width: 4),
                    restaurant.isOpen
                        ? SvgPicture.asset(
                            'assets/svg/circle_green.svg',
                            // width: 8,
                          )
                        : SvgPicture.asset(
                            'assets/svg/circle_red.svg',
                            // width: 16,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
