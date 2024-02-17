import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:restaurantour/common/ui/themes.dart';
import 'package:restaurantour/common/utils/constants.dart';
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
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
        ],
        child: ResponsiveScaledBox(
          width: Constants.designWidth,
          child: child!,
        ),
      ),
      home: BlocProvider<RestaurantsCubit>(
        create: (_) =>
            injection.dependency<RestaurantsCubit>()..loadRestaurantsList(),
        child: const RestaurantsScreen(),
      ),
    );
  }
}
