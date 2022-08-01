import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/l10n/l10n.dart';
import 'package:restaurantour/restaurant_detail/restaurant_detail.dart';

import 'package:restaurantour_ui/restaurantour_ui.dart';

import '../home.dart';

class AllRestaurantList extends StatelessWidget {
  const AllRestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return previous.allRestaurantsStatus != current.allRestaurantsStatus;
      },
      builder: (context, state) {
        final allRestaurantsStatus = state.allRestaurantsStatus;
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
        final isLoading = allRestaurantsStatus == HomeListStatus.loading;
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
                  child: ViewMoreButton(
                    isLoading: isLoading,
                    onPressed: () {
                      context.read<HomeCubit>().loadRestaurants();
                    },
                  ),
                ),
              );
            }
            final restaurant = state.allRestaurants[index];
            return RestaurantCard(
              title: restaurant.name,
              category: restaurant.category,
              imageUrl: restaurant.photoUrl,
              rating: restaurant.rating?.round(),
              price: restaurant.price,
              isOpenNow: restaurant.isOpenNow ?? false,
              openText: l10n.attentionStatusOpen,
              closedText: l10n.attentionStatusClosed,
              defaultRestaurantName: l10n.defaultRestaurantName,
              heroTag: restaurant.id!,
              onTap: () {
                Navigator.push(
                  context,
                  RestaurantDetailPage.route(restaurant.id!),
                );
              },
            );
          },
        );
      },
    );
  }
}
