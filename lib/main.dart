import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/managers/favorites_manager.dart';

import 'package:restaurantour/pages/home_page.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/services/yelp_service.dart';
import 'package:restaurantour/utils/strings.dart';

import 'managers/favorites_manager_mock.dart';
import 'managers/restaurants_manager.dart';
import 'managers/restaurants_manager_mock.dart';

part 'handlers/manager_handler.dart';
part 'handlers/error_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  registerErrorHandlers();
  registerManagerHandlers();

  runApp(const RestauranTour());
}

class RestauranTour extends StatelessWidget {
  const RestauranTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.title,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
