import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superformula_flutter_test/screens/restaurant_detail_screen.dart';
import 'package:superformula_flutter_test/widgets/custom_error_widget.dart';

import '../blocs/restaurant_list/restaurant_list_bloc.dart';
import 'restaurant_tile.dart';

class RestaurantsList extends StatefulWidget {
  const RestaurantsList({Key? key}) : super(key: key);
  @override
  State<RestaurantsList> createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> {
  final RestaurantListBloc _restaurantListBloc = RestaurantListBloc();

  @override
  void initState() {
    super.initState();
    _restaurantListBloc.add(FetchRestaurants(0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantListBloc, RestaurantListState>(
      bloc: _restaurantListBloc,
      builder: (context, state) {
        if (state is RestaurantListLoaded) {
          return ListView.builder(
            itemCount: state.restaurantResult.restaurants.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantDetailScreen(restaurant: state.restaurantResult.restaurants[index]),
                  ),
                ),
                child: RestaurantTile(restaurant: state.restaurantResult.restaurants[index]),
              );
            },
          );
        }
        if (state is RestaurantListError) {
          return CustomErrorWidget();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
