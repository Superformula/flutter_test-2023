import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';
import 'package:restaurantour/presentation/restaurant_details/widgets/widgets.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

class RestaurantDetailsView extends StatelessWidget {
  const RestaurantDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = context.read<RestaurantDetailsCubit>().state.maybeWhen(
          loaded: (restaurant) => restaurant,
          orElse: () => const Restaurant(),
        );
    return Scaffold(
      appBar: const DetailsAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              restaurant.heroImage,
              height: 360,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoSection(),
                  Divider(height: 48),
                  AddressSection(),
                  Divider(height: 48),
                  RatingSection(),
                  Divider(height: 48),
                  ReviewsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
