import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/common/ui/themes.dart';
import 'package:restaurantour/injection_container.dart' as injection;
import 'package:restaurantour/features/restaurant/presentation/cubit/all_restaurants_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_screen.dart';

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AllRestaurantsCubit>(
            create: (_) => injection.dependency<AllRestaurantsCubit>()
              ..loadRestaurantsList(),
          ),
        ],
        child: const RestaurantsScreen(),
      ),
    );
  }
}
