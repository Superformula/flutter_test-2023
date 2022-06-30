import 'package:flutter/material.dart';
import 'package:restaurantour/app/app.dart';
import 'package:restaurantour/app/app_bloc_observer.dart';
import 'package:restaurantour/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await bootstrap(() => const App());
}
