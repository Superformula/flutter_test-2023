import 'package:flutter/material.dart';
import 'package:restaurantour/core/theme/app_theme.dart';
import 'package:restaurantour/core/utils/dependency_injector.dart';

import 'modules/home/ui/home_page.dart';

void main() {
  // Initialize Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Injections
  setupServicesLocator();

  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      home: const HomePage(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
