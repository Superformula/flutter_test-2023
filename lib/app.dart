import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/business_logic/favorite/favorite_cubit.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';
import 'package:restaurantour/presentation/pages/home_page.dart';

import 'business_logic/restaurants/restaurants_cubit.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late YelpRepository repository;

  @override
  void initState() {
    super.initState();
    repository = GetIt.I<YelpRepository>();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<RestaurantsCubit>(
              create: (context) => RestaurantsCubit(repository),
            ),
            BlocProvider<FavoriteCubit>(
              create: (context) => FavoriteCubit(),
            ),
          ],
          child: const HomePage(),
        ),
      );
}
