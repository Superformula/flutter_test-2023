import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'managers/favorites_manager.dart';
import 'managers/favorites_manager_mock.dart';
import 'managers/restaurants_manager.dart';
import 'managers/restaurants_manager_mock.dart';
import 'services/router_service.dart';
import 'services/yelp_service.dart';
import 'utils/strings.dart';

part 'handlers/manager_handler.dart';
part 'handlers/error_handler.dart';
part 'handlers/hive_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  registerHiveHandler();
  registerErrorHandlers();
  registerManagerHandlers();

  runApp(const RestauranTour());
}

class RestauranTour extends StatelessWidget {
  const RestauranTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.title,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: rService.config(),
    );
  }
}
