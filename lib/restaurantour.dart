import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/logic/favourite_restaurants_bloc/favourite_restaurants_bloc.dart';
import 'package:restaurantour/logic/restaurants_bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/views/home/home_page.dart';

import 'data/repositories/yelp_repository.dart';

class RestaurantTour extends StatelessWidget {
  const RestaurantTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => YelpRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RestaurantsBloc(
              yelpRepository: RepositoryProvider.of<YelpRepository>(context),
            )..add(
                LoadRestaurants(),
              ),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => FavouriteRestaurantsBloc(
              yelpRepository: RepositoryProvider.of<YelpRepository>(context),
            ),
          ),
        ],
        child: const RestauranTourView(),
      ),
    );
  }
}

class RestauranTourView extends StatelessWidget {
  const RestauranTourView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'restauranttour',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
