import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';
import 'package:restaurantour/presentation/common/restaurant_card/restaurant_card.dart';
import 'package:restaurantour/presentation/views/restaurant/restaurant_page.dart';

class RestaurantsListView extends StatelessWidget {
  final List<Restaurant> list;
  const RestaurantsListView(this.list, {Key? key}) : super(key: key);

  void onTapRestaurant(BuildContext context, Restaurant restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RepositoryProvider.value(
          value: RepositoryProvider.of<YelpRepository>(context),
          child: RestaurantPage(restaurant),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: list.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        return RestaurantCard(
          list[index],
          onTap: () => onTapRestaurant(context, list[index]),
        );
      },
    );
  }
}
