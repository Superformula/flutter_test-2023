import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Home/view/home_view.dart';
import 'package:restaurantour/Modules/Home/viewmodel/home_viewmodel.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_adapter.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_service.dart';
import 'package:restaurantour/repositories/restaurants/restaurants_repository.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class HomeInjection extends StatelessWidget {
  const HomeInjection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewmodel(
        RestaurantsRepository(
          yelpRepository: YelpRepository(),
          sharedPreferences: SharedPreferencesService(
            SharedpreferencesAdapter(),
          ),
        ),
        SharedPreferencesService(
          SharedpreferencesAdapter(),
        ),
      ),
      child: const HomeView(),
    );
  }
}
