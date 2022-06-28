import 'package:flutter/material.dart';
import 'package:restaurantour/ui/router.dart';
import 'package:restaurantour/ui/theme/app_theme.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RestauranTour',
      theme: AppTheme.lightThemeData(),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
