import 'package:flutter/material.dart';
import 'package:restaurantour/ui/screens/restarautour_home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/my_favorites/favorites_restaurants_bloc.dart';
import 'bloc/restaurants/restaurants_bloc.dart';
import 'bloc/restaurants/restaurants_event.dart';
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
        home: const RestauranTourHomeScreen(),
      ),
    );
  }
}
