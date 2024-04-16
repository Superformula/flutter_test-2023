import 'package:flutter/material.dart';
import 'package:restaurantour/core/di/di.dart';
import 'package:restaurantour/restaurant_tour_app.dart';

void main() {
  configureDependencies();
  runApp(
    const RestauranTourApp(),
  );
}
