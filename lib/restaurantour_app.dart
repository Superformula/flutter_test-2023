import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/common/ui/themes.dart';
import 'package:restaurantour/features/restaurant/presentation/cubit/restaurants_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_screen.dart';
import 'package:restaurantour/injection_container.dart' as injection;

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: ThemeData.from(
        colorScheme: Themes.colorTheme,
        textTheme: Themes.textTheme,
      ).copyWith(
        iconTheme: Themes.iconTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<RestaurantsCubit>(
        create: (_) =>
            injection.dependency<RestaurantsCubit>()..loadRestaurantsList(),
        child: const RestaurantsScreen(),
      ),
    );
  }
}
