import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';
import 'package:restaurantour/presentation/pages/widgets/custom_progress_indicator.dart';
import 'package:restaurantour/presentation/pages/widgets/restaurant_card.dart';

class RestaurantListWidget extends StatelessWidget {
  const RestaurantListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding:  EdgeInsets.only(top: 20.0),
            child:  Text(
              'RestauranTour',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.black,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            tabAlignment: TabAlignment.center,
            tabs: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'All Restaurants',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'My Favourites',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
            builder: (context, state) {
              if (state is RestaurantsEmpty) {
                return Container();
              }
              if (state is RestaurantsLoading) {
                return const Center(child: CustomProgressIndicator());
              }
              if (state is RestaurantsLoadFail) {
                return Column(
                  children: [
                    const Center(
                      key: Key('error'),
                      child: Text('Error'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      onPressed: () => context
                          .read<RestaurantsBloc>()
                          .add(const OnRequestedRestaurants()),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                );
              }
              if (state is RestaurantsLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.length,
                  itemBuilder: (context, index) {
                    return RestaurantListCard(
                      restaurantEntity: state.result[index],
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
