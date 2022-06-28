import 'package:flutter/material.dart';
import 'package:restaurantour/app_bloc_observer.dart';
import 'package:restaurantour/di/injection.dart';
import 'package:restaurantour/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await bootstrap(() => const App());
}
