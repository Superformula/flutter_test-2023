import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/presenter/bloc/favorite_restaurants_bloc.dart';
import 'package:restaurantour/features/restaurant_page/presenter/bloc/restaurant_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.restaurant,
  }) : super(key: key);

  final String title;
  final Restaurant restaurant;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    bool isFavorited = false;
    return AppBar(
      leading: BackButton(
        onPressed: () {
          context.pop(!isFavorited);
        },
      ),
      title: Text(title),
      actions: [
        BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const CircularProgressIndicator();
            } else if (state is VerifiedState) {
              isFavorited = state.isFavorited;
              return IconButton(
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: isFavorited ? Colors.red : null,
                ),
                onPressed: () {
                  if (!isFavorited) {
                    context
                        .read<RestaurantBloc>()
                        .add(AddFavoriteEvent(restaurantId: restaurant.id!));
                  } else {
                    context
                        .read<RestaurantBloc>()
                        .add(RemoveFavoriteEvent(restaurantId: restaurant.id!));
                  }
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
