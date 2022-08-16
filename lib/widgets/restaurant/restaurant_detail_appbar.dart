import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superformula_flutter_test/blocs/restaurants/restaurants_bloc.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';

class RestaurantDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Restaurant restaurant;
  const RestaurantDetailAppBar({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RestaurantsBloc restaurantsBloc = BlocProvider.of<RestaurantsBloc>(context, listen: false);
    return AppBar(
      backgroundColor: Colors.white,
      leading: const BackButton(color: Colors.black),
      title: Text(restaurant.name ?? "N/A", style: const TextStyle(color: Colors.black)),
      actions: [
        IconButton(
          onPressed: () => restaurantsBloc.add(ToggleFavoriteRestaurant(restaurant)),
          color: Colors.black,
          icon: Icon(context.watch<RestaurantsBloc>().favoriteRestaurants.contains(restaurant) ? Icons.favorite : Icons.favorite_outline),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
