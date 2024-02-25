import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/domain/restaurants/entities/entities.dart';
import 'package:restaurantour/presentation/app/constants/constants.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';
import 'package:restaurantour/presentation/restaurant_details/widgets/widgets.dart';

class RestaurantDetailsView extends StatelessWidget {
  const RestaurantDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = context.read<RestaurantDetailsCubit>().state.maybeWhen(
          loaded: (restaurant) => restaurant,
          orElse: () => const RestaurantEntity(),
        );
    return Scaffold(
      appBar: const DetailsAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              restaurant.heroImage,
              height: Spacing.xxlg * Spacing.sm,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: Spacing.xlg),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xlg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoSection(),
                  Divider(height: Spacing.xxlg),
                  AddressSection(),
                  Divider(height: Spacing.xxlg),
                  RatingSection(),
                  Divider(height: Spacing.xxlg),
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
