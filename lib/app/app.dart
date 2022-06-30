import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/blocs/restaurants/restaurants_cubit.dart';
import 'package:restaurantour/core/di/injection.dart';
import 'package:restaurantour/ui/router/router.dart';
import 'package:restaurantour/ui/theme/app_theme.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RestaurantsCubit>()..getRestaurants(),
      child: MaterialApp.router(
        title: 'RestauranTour',
        theme: AppTheme.lightThemeData(),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}
