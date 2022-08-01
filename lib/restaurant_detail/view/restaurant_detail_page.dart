import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/restaurant_detail/restaurant_detail.dart';
import 'package:restaurantour/restaurant_detail/widgets/favorite_button.dart';
import 'package:restaurantour/restaurant_detail/widgets/restaurant_detail_information.dart';
import 'package:restaurantour_ui/restaurantour_ui.dart';
import 'package:user_repository/user_repository.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  final String restaurantId;

  static Route route(String restaurantId) {
    return MaterialPageRoute<void>(
      builder: (context) => RestaurantDetailPage(restaurantId: restaurantId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantDetailCubit(
        restaurantId: restaurantId,
        userRepository: context.read<UserRepository>(),
        restaurantRepository: context.read<RestaurantRepository>(),
      )..init(),
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
    final imageHeight = MediaQuery.of(context).size.height * 0.5;

    return BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        final restaurant = state.restaurant;
        return Scaffold(
          appBar: AppBar(
            title: Text(restaurant.name ?? ''),
            elevation: 0,
            actions: [
              Visibility(
                visible: state.status == RestaurantDetailStatus.loaded,
                child: const FavoriteButton(),
              )
            ],
          ),
          body: Builder(
            builder: (_) {
              if (state.status == RestaurantDetailStatus.initial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == RestaurantDetailStatus.error) {
                return const Center(child: Icon(Icons.error));
              }
              return CustomScrollView(
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
              );
            },
          ),
        );
      },
    );
  }
}
