import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/core/models/restaurant.dart';
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
    return AppBar(
      leading: BackButton(
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(title),
      actions: [
        BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const CircularProgressIndicator();
            } else if (state is VerifiedState) {
              return IconButton(
                icon: Icon(
                  state.isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: state.isFavorited ? Colors.red : null,
                ),
                onPressed: () {
                  if (!state.isFavorited) {
                    context.read<RestaurantBloc>().add(
                          AddFavoriteEvent(restaurantId: restaurant.id!),
                        );
                    context.read<RestaurantBloc>().add(
                          CheckFavoriteEvent(restaurant: restaurant),
                        );
                  } else {
                    context.read<RestaurantBloc>().add(
                          RemoveFavoriteEvent(restaurantId: restaurant.id!),
                        );
                    context.read<RestaurantBloc>().add(
                          CheckFavoriteEvent(restaurant: restaurant),
                        );
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
