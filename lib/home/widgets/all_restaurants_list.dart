import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/l10n/l10n.dart';

import 'package:restaurantour_ui/restaurantour_ui.dart';

import '../home.dart';

class AllRestaurantList extends StatelessWidget {
  const AllRestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return previous.allRestaurants != current.allRestaurants;
      },
      builder: (context, state) {
        final allRestaurantsStatus =
            context.watch<HomeCubit>().state.allRestaurantsStatus;
        if (allRestaurantsStatus == HomeListStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (allRestaurantsStatus == HomeListStatus.error) {
          return const Center(
            child: Icon(Icons.error),
          );
        }
        final isCompleted = allRestaurantsStatus == HomeListStatus.completed;
        final restaurants = state.allRestaurants;
        return ListView.separated(
          key: const Key('homeView_allRestaurantList'),
          // ! One element is added to show ViewMoreButton
          itemCount: state.allRestaurants.length + (isCompleted ? 0 : 1),
          padding: const EdgeInsets.symmetric(
            horizontal: RestaurantourPaddingValues.big,
            vertical: RestaurantourPaddingValues.l,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: RestaurantourPaddingValues.big,
          ),
          itemBuilder: (context, index) {
            final isLastItem = index == restaurants.length;
            if (isLastItem && !isCompleted) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(RestaurantourPaddingValues.big),
                  child: ViewMoreButton(onPressed: () {}),
                ),
              );
            }
            final restaurant = state.allRestaurants[index];
            return RestaurantCard(
              title: restaurant.name ?? '',
              category: restaurant.category ?? '',
              imageUrl:
                  restaurant.photoUrl ?? 'https://via.placeholder.com/150',
              rating: restaurant.rating?.round() ?? 0,
              price: restaurant.price ?? '',
              attentionStatusText: l10n.attentionStatusOpen,
              attentionStatusIconColor: RestaurantourColors.open,
              onTap: () {},
            );
          },
        );
      },
    );
  }
}
