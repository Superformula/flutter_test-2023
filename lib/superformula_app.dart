import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superformula_flutter_test/screens/restaurant_detail_screen.dart';

import 'blocs/restaurant_list/restaurant_list_bloc.dart';
import 'models/restaurant.dart';
import 'screens/restaurant_list_screen.dart';

class SuperformulaApp extends StatelessWidget {
  const SuperformulaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantListBloc()..add(FetchRestaurants(0)),
      child: MaterialApp(
        title: 'Superformula Test',
        debugShowCheckedModeBanner: false,
        home: const RestaurantListScreen(),
        routes: {
          RestaurantListScreen.id: (context) => RestaurantListScreen(),
          RestaurantDetailScreen.id: (context) => RestaurantDetailScreen(restaurant: Restaurant.empty(), heroTag: 0),
        },
      ),
    );
  }
}
