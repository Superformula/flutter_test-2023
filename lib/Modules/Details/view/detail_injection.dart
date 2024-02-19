import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Details/view/detail_view.dart';
import 'package:restaurantour/Modules/Details/viewmodel/detail_viewmodel.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_adapter.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_service.dart';
import 'package:restaurantour/models/restaurant.dart';

class DetailInjection extends StatelessWidget {
  const DetailInjection({
    Key? key,
    required this.restaurant,
    required this.favoriteRestaurants,
  }) : super(key: key);

  final Restaurant restaurant;
  final RestaurantQueryResult favoriteRestaurants;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailViewmodel(
        restaurant: restaurant,
        favoriteRestaurants: favoriteRestaurants,
        sharedPreferencesService: SharedPreferencesService(
          SharedpreferencesAdapter(),
        ),
      ),
      child: const DetailView(),
    );
  }
}
