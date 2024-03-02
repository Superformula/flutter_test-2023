import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/components/address.dart';
import 'package:restaurantour/presentation/components/open_closed.dart';
import 'package:restaurantour/presentation/components/overall_rating.dart';
import 'package:restaurantour/presentation/components/price_category.dart';
import 'package:restaurantour/presentation/components/reviews.dart';
import 'package:restaurantour/presentation/details/restaurant_details_cubit.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantDetailsCubit, Restaurant>(
      builder: (context, restaurant) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              restaurant.name ?? '',
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar(
                  expandedHeight: 450,
                  floating: false,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'restaurant-hero-image-${restaurant.id}',
                      child: Image.network(
                        restaurant.heroImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceCategory(
                      category: restaurant.displayCategory,
                      price: restaurant.price,
                    ),
                    OpenClosed(open: restaurant.isOpen),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 15),
                Address(location: restaurant.location),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 15),
                OverallRating(rating: restaurant.rating),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 15),
                Reviews(reviews: restaurant.reviews ?? []),
              ],
            ),
          ),
        );
      },
    );
  }
}
