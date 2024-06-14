import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/business_logic/favorite/favorite_cubit.dart';

import '../../models/restaurant.dart';
import '../widgets/restaurant_card_widget.dart';
import 'restaurants_page.dart';

class FavoritesPage extends StatefulWidget {
  final List<Restaurant> restaurants;

  const FavoritesPage({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoriteCubit get favoriteCubit => context.read<FavoriteCubit>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.builder(
        itemCount: widget.restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = widget.restaurants.elementAt(index);
          return RestaurantCardWidget(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => BlocProvider.value(
                  value: favoriteCubit,
                  child: RestaurantPage(
                    restaurant: restaurant,
                  ),
                ),
              ),
            ),
            restaurant: widget.restaurants[index],
          );
        },
      ),
    );
  }
}
