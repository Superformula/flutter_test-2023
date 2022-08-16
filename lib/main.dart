import 'package:flutter/material.dart';
import 'blocs/restaurants/restaurants_bloc.dart';
import 'services/network_provider.dart';
import 'superformula_app.dart';

void main() => runApp(
      SuperformulaApp(
        restaurantsBloc: RestaurantsBloc(NetworkProvider())..add(FetchRestaurants(0)),
      ),
    );
