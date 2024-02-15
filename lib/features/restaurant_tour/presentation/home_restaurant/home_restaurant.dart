import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/features/restaurant_tour/bloc/restaurant_bloc.dart';
import 'package:restaurantour/features/restaurant_tour/repositories/yelp_repository.dart';

class HomeResturant extends StatelessWidget {
  const HomeResturant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Restaurantour'),
                ElevatedButton(
                  child: const Text('Fetch Restaurants'),
                  onPressed: () async {
                    final yelpRepo = YelpRepository();

                    try {
                      final result = await yelpRepo.getRestaurants();
                      if (result != null) {
                        print(
                          'Fetched ${result.restaurants!.length} restaurants',
                        );
                      } else {
                        print('No restaurants fetched');
                      }
                    } catch (e) {
                      print('Failed to fetch restaurants: $e');
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
