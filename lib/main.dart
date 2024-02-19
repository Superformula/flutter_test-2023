import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/injection_container.dart';
import 'package:restaurantour/presentation/bloc/favourite_restaurants_bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:restaurantour/presentation/pages/restaurant_list_page.dart';

void main() {
  setUpLocator();
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<RestaurantsBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<RestaurantDetailsBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<ReviewBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<FavouriteRestaurantsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'RestauranTour',
        theme: ThemeData(
          textTheme: GoogleFonts.loraTextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RestaurantListPage();

    // Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       const Text('Restaurantour'),
    //       ElevatedButton(
    //         child: const Text('Fetch Restaurants'),
    //         onPressed: () async {
    //           final yelpRepo = YelpRepository();

    //           try {
    //             final result = await yelpRepo.getRestaurants();
    //             if (result != null) {
    //               print('Fetched ${result.restaurants!.length} restaurants');
    //             } else {
    //               print('No restaurants fetched');
    //             }
    //           } catch (e) {
    //             print('Failed to fetch restaurants: $e');
    //           }
    //         },
    //       ),
    //     ],
    //   ),
    // ),
  }
}
