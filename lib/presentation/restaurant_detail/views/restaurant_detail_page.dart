import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/core/di/di.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/presentation/cubit/cubit.dart';
import 'package:restaurantour/presentation/restaurant_detail/views/views.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({super.key, this.restaurantEntity});

  final RestaurantEntity? restaurantEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteRestaurantsCubit>.value(
      value: getIt<FavoriteRestaurantsCubit>(),
      child: RestaurantDetailView(
        restaurant: restaurantEntity,
      ),
    );
  }
}
