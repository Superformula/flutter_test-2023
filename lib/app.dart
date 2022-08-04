import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/favorites_restaurants/favorites_restaurants_bloc.dart';
import 'bloc/restaurants/restaurants_bloc.dart';
import 'bloc/restaurants/restaurants_event.dart';
import 'bloc/selected_restaurant/selected_restaurant_bloc.dart';
import 'presentation/router/app_router.dart';
import 'repositories/yelp_repository.dart';

class Restaurantour extends StatelessWidget {
  const Restaurantour({required this.yelpRepository, super.key});

  final YelpRepository yelpRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantsBloc>(
          create: (BuildContext context) => RestaurantsBloc(
            yelpRepository: yelpRepository,
          )..add(FetchedRestaurantsStarted()),
        ),
        BlocProvider<SelectedRestaurantBloc>(
          create: (BuildContext context) => SelectedRestaurantBloc(),
        ),
        BlocProvider<FavoritesRestaurantsBloc>(
          create: (BuildContext context) => FavoritesRestaurantsBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RestauranTour',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
