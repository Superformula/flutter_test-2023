import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/controllers/favorite/favorite_cubit.dart';

import '../../models/restaurant.dart';
import '../widgets/restaurant_card_widget.dart';

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
  void initState() {
    super.initState();
    favoriteCubit.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.builder(
        itemCount: widget.restaurants.length,
        itemBuilder: (context, index) => RestaurantCardWidget(
          favoriteCubit: favoriteCubit,
          restaurant: widget.restaurants[index],
        ),
      ),
    );
  }
}
