import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/business_logic/favorite/favorite_cubit.dart';
import 'package:restaurantour/presentation/pages/home_page.dart';

import 'business_logic/restaurants/restaurants_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<RestaurantsCubit>(
              create: (context) => RestaurantsCubit(),
            ),
            BlocProvider<FavoriteCubit>(
              create: (context) => FavoriteCubit(),
            ),
          ],
          child: const HomePage(),
        ),
      );
}
