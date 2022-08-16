import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superformula_flutter_test/screens/restaurant_detail_screen.dart';

import 'blocs/restaurant_list/restaurant_list_bloc.dart';
import 'models/restaurant.dart';
import 'screens/restaurant_list_screen.dart';

class SuperformulaApp extends StatelessWidget {
  final RestaurantListBloc restaurantListBloc;
  const SuperformulaApp({Key? key, required this.restaurantListBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: restaurantListBloc,
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
