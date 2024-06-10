import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/bloc/restaurant_list_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/widgets/restaurant_item_widget.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurantour'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            GetIt.instance<RestaurantListCubit>()..fetchRestaurants(),
        child: BlocBuilder<RestaurantListCubit, RestaurantListState>(
          builder: (context, state) {
            if (state is RestaurantListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is RestaurantListLoaded) {
              return ListView.builder(
                itemCount: state.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = state.restaurants[index];
                  return RestaurantItemWidget(
                    restaurant: restaurant,
                  );
                },
              );
            }

            if (state is RestaurantListError) {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return RestaurantItemWidget(
                      restaurant: Restaurant(
                        id: '1',
                        name: 'Gordon Ramsay Hell\'s Kitchen',
                        price: '\$\$\$',
                        rating: 4.5,
                        photos: [
                          'https://lh5.googleusercontent.com/p/AF1QipMbAecKbQuQpZO8mVoGpsNzV6C7OnjIsOfQOtgt=w114-h114-n-k-no'
                        ],
                        categories: [
                          Category(alias: 'newamerican', title: 'New American')
                        ],
                        hours: [Hours(isOpenNow: true)],
                        reviews: [],
                        location:
                            Location(formattedAddress: '123 Example St, City'),
                      ),
                    );
                  });
            }

            return const Center(
              child: Text('Restaurantour'),
            );
          },
        ),
      ),
    );
  }
}
