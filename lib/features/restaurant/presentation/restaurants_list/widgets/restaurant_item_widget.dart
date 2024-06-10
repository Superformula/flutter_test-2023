import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';

class RestaurantItemWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItemWidget({required this.restaurant, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              restaurant.heroImage,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome do restaurante no topo
                Text(
                  restaurant.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                // Preço e categoria
                Text(
                  '${restaurant.price ?? ''} ${restaurant.displayCategory}',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),

                // Avaliações e restaurant.isOpen na parte inferior
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      // Avaliações
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (restaurant.rating ?? 0).round()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                      ),

                      // Espaço entre as avaliações e restaurant.isOpen
                      Expanded(child: Container()),

                      // restaurant.isOpen
                      Row(
                        children: [
                          Text(
                            restaurant.isOpen ? 'Open Now' : 'Closed',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.circle,
                            color:
                                restaurant.isOpen ? Colors.green : Colors.red,
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
