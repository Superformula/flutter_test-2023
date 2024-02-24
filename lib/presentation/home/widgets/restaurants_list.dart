import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:restaurantour/presentation/app/widgets/widgets.dart';
import 'package:restaurantour/presentation/home/state_management/home_cubit/home_cubit.dart';
import 'package:restaurantour/presentation/home/widgets/widgets.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

class RestaurantsList extends StatelessWidget {
  const RestaurantsList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PagedSliverList(
          pagingController: context.read<HomeCubit>().pagingController,
          builderDelegate: PagedChildBuilderDelegate<Restaurant>(
            animateTransitions: true,
            firstPageProgressIndicatorBuilder: (context) => const Center(
              child: LoadingSpinner(),
            ),
            newPageProgressIndicatorBuilder: (context) => const Center(
              child: Center(
                child: LoadingSpinner(
                  size: 20,
                ),
              ),
            ),
            itemBuilder: (_, item, index) {
              return RestaurantItem(restaurant: item);
            },
          ),
        ),
      ],
    );
  }
}
