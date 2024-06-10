import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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

            return const Center(
              child: Text('Restaurantour'),
            );
          },
        ),
      ),
    );
  }
}
