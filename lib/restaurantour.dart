import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';
import 'package:restaurantour/logic/restaurants/restaurants_bloc.dart';
import 'package:restaurantour/presentation/views/home/home_page.dart';

class RestaurantTour extends StatelessWidget {
  const RestaurantTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              RestaurantsBloc(yelpRepository: YelpRepository()),
        ),
      ],
      child: const RestauranTourView(),
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
