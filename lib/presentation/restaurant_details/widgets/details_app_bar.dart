import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';

class DetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;
    final colors = appTheme.colors;

    final restaurant = context.read<RestaurantDetailsCubit>().state.restaurant;

    return AppBar(
      title: Text(restaurant?.name ?? '', style: typography.headingH6),
      backgroundColor: Colors.white,
      shadowColor: colors.black?.withOpacity(0.2),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: colors.black,
        ),
        onPressed: context.pop,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
