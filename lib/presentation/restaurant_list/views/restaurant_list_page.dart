import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/core/di/di.dart';
import 'package:restaurantour/presentation/cubit/cubit.dart';
import 'package:restaurantour/presentation/restaurant_list/bloc/bloc.dart';
import 'package:restaurantour/presentation/restaurant_list/views/views.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantListBloc>(
          create: (_) => getIt<RestaurantListBloc>(),
        ),
        BlocProvider<FavoriteRestaurantsCubit>.value(
          value: getIt<FavoriteRestaurantsCubit>(),
        ),
      ],
      child: const RestaurantListView(),
    );
  }
}
