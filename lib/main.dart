import 'package:flutter/material.dart';
import 'blocs/restaurant_list/restaurant_list_bloc.dart';
import 'services/network_provider.dart';
import 'superformula_app.dart';

void main() => runApp(
      SuperformulaApp(
        restaurantListBloc: RestaurantListBloc(NetworkProvider())..add(FetchRestaurants(0)),
      ),
    );
