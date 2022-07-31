import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/l10n/l10n.dart';
import 'package:restaurantour/restaurant_detail/restaurant_detail.dart';
import 'package:restaurantour/restaurant_detail/widgets/favorite_button.dart';
import 'package:restaurantour/restaurant_detail/widgets/restaurant_detail_information.dart';
import 'package:restaurantour_ui/restaurantour_ui.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  static Route route(Restaurant restaurant) {
    return MaterialPageRoute<void>(
      builder: (context) => RestaurantDetailPage(restaurant: restaurant),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantDetailCubit(restaurant: restaurant),
      child: const RestaurantDetailView(),
    );
  }
}

class RestaurantDetailView extends StatelessWidget {
  const RestaurantDetailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final restaurant = context.select<RestaurantDetailCubit, Restaurant>(
      (cubit) => cubit.state.restaurant,
    );
    final imageHeight = MediaQuery.of(context).size.height * 0.5;
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name ?? l10n.defaultRestaurantName),
        elevation: 0,
        actions: const [FavoriteButton()],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Hero(
              tag: restaurant.id!,
              child: SizedBox(
                width: double.infinity,
                height: imageHeight,
                child: restaurant.photoUrl == null
                    ? Container(
                        color: RestaurantourColors.placeholder,
                      )
                    : CachedNetworkImage(
                        imageUrl: restaurant.photoUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: RestaurantourColors.placeholder,
                        ),
                        errorWidget: (_, __, ___) =>
                            const Center(child: Icon(Icons.error)),
                      ),
              ),
            ),
          ),
          const RestaurantDetailInformation()
        ],
      ),
    );
  }
}
