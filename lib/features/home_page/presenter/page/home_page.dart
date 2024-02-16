import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/features/home_page/presenter/bloc/home_bloc.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/shared/tr_skeleton.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      child: _Page(),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RestauranTour'),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TrSkeleton(
            height: 50,
            width: 100,
          ),
          const Text('Restaurantour'),
          ElevatedButton(
            child: const Text('Fetch Restaurants'),
            onPressed: () async {
              final yelpRepo = YelpRepository();

              try {
                final result = await yelpRepo.getRestaurants();
                if (result != null) {
                  print('Fetched ${result.restaurants!.length} restaurants');
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
  }
}
