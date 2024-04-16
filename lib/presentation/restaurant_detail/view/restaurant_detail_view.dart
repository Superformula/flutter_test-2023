import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/presentation/restaurant_detail/mixins/restaurant_mixin.dart';
import 'package:restaurantour/presentation/restaurant_detail/cubit/cubit.dart';
import 'package:restaurantour/presentation/restaurant_detail/widgets/widgets.dart';

class RestaurantDetailView extends StatefulWidget {
  const RestaurantDetailView({
    super.key,
    this.restaurant,
  });

  final RestaurantEntity? restaurant;

  @override
  State<RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView>
    with RestaurantMixin {
  late FavoriteRestaurantsCubit _favoriteRestaurantsCubit;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _favoriteRestaurantsCubit =
        BlocProvider.of<FavoriteRestaurantsCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    var restaurantItem = widget.restaurant;

    return Scaffold(
      key: const Key('scaffold'),
      backgroundColor: AppColors.white,
      appBar: AppBar(
        key: const Key('appBar'),
        title: Text(
          overflow: TextOverflow.ellipsis,
          restaurantItem?.name ?? "",
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: BlocConsumer<FavoriteRestaurantsCubit,
                FavoriteRestaurantsListState>(
              bloc: _favoriteRestaurantsCubit,
              listener: (context, state) {
                if (state.status == StatusEnum.success) {
                  isFavorite =
                      state.restaurantsList?.contains(restaurantItem) ?? false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? AppWords.addedToMyFavorites
                            : AppWords.removedFromMyFavorites,
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                isFavorite = state.restaurantsList!.contains(restaurantItem);

                return IconButton(
                  key: const Key("icon-button"),
                  icon: Icon(
                    key: const Key("icon"),
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: isFavorite ? AppColors.black : null,
                  ),
                  onPressed: () {
                    _favoriteRestaurantsCubit.toggleFavorite(restaurantItem!);
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                RestaurantHeroImageWidget(
                  key: const Key('restaurant-hero-image-widget'),
                  restaurantEntity: restaurantItem,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PriceCategoryBusinessHoursWidget(
                        key: const Key('price-category-business-hours-widget'),
                        restaurantEntity: restaurantItem!,
                      ),
                      AddressOverallRatingWidget(
                        key: const Key('address-overall-rating-widget'),
                        restaurantEntity: restaurantItem,
                      ),
                      ReviewsWidget(
                        key: const Key('review-widget'),
                        restaurantEntity: restaurantItem,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
