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
    return ListView.separated(
      key: const Key('homeView_allRestaurantList'),
      // TODO: change for real value
      itemCount: isCompleted ? 10 : 10 + 1,
      padding: const EdgeInsets.symmetric(
        horizontal: RestaurantourPaddingValues.big,
        vertical: RestaurantourPaddingValues.l,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: RestaurantourPaddingValues.big,
      ),
      itemBuilder: (context, index) {
        // Change for real value
        if (index == 10 && !isCompleted) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(RestaurantourPaddingValues.big),
              child: ViewMoreButton(onPressed: () {}),
            ),
          );
        }
        return RestaurantCard(
          title: 'Restaurant Name Goes Here And Wraps 2 Lines',
          category: 'Italian',
          imageUrl: 'https://via.placeholder.com/150',
          rating: 5,
          price: '\$\$\$',
          attentionStatusText: l10n.attentionStatusOpen,
          attentionStatusIconColor: RestaurantourColors.open,
          onTap: () {},
        );
      },
    );
  }
}
