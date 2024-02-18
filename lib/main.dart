import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/injection_container.dart';
import 'package:restaurantour/presentation/bloc/RestaurantsBloc.dart';
import 'package:restaurantour/presentation/pages/restaurant_list_page.dart';

void main() {
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => locator<RestaurantsBloc>(),)],
        child: const RestaurantListPage(),
      )
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
    );
  }
}
