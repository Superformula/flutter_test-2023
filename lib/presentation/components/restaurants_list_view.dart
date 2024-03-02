import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/components/open_closed.dart';
import 'package:restaurantour/presentation/components/price_category.dart';
import 'package:restaurantour/presentation/components/rating_stars.dart';
import 'package:restaurantour/presentation/details/restaurant_details.dart';
import 'package:restaurantour/presentation/details/restaurant_details_cubit.dart';

class RestaurantsListView extends StatelessWidget {
  const RestaurantsListView({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 2,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (_) => RestaurantDetailsCubit(restaurant),
                        child: const RestaurantDetails(),
                      );
                    },
                  ),
                );
              },
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'restaurant-hero-image-${restaurant.id}',
                        child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            restaurant.heroImage,
                            height: 84,
                            width: 84,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                restaurant.name ?? '',
                                style: const TextStyle(fontSize: 18),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PriceCategory(
                                  price: restaurant.price,
                                  category: restaurant.displayCategory,
                                ),
                                Row(
                                  children: [
                                    RatingStars(rating: restaurant.rating),
                                    const Spacer(),
                                    OpenClosed(open: restaurant.isOpen),
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
      },
    );
  }
}
