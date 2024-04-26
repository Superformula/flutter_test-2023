import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/logic/restaurant/restaurant_bloc.dart';
import 'package:restaurantour/pages/pages.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

const listPage = '/';
const detailPage = '/detail';

final router = GoRouter(
  initialLocation: listPage,
  routes: [
    GoRoute(
      path: listPage,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => RestaurantBloc(
            yelpRepository: context.read<YelpRepository>(),
          )..add(const RestaurantEvent.getRestaurants()),
          child: const HomePage(),
        );
      },
      routes: [
        GoRoute(
          path: 'detail',
          builder: (context, state) => const DetailPage(),
        ),
      ],
    ),
  ],
);
