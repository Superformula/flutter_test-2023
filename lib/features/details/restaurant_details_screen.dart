import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/restaurant_review_widget.dart';
import 'package:restaurantour/components/rt_error_widget.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/core/rt_colors.dart';
import 'package:restaurantour/core/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:restaurantour/features/details/restaurant_details_view_model.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/services/favorites_service.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  const RestaurantDetailsScreen({super.key, required this.restaurant, required this.imageNetwork});
  final Restaurant restaurant;
  final RTImageNetwork imageNetwork;
  static Widget create({required Restaurant restaurant, required RTImageNetwork imageNetwork}) => ChangeNotifierProvider(
        create: (context) => RestaurantDetailsViewModel(
          restaurantId: restaurant.id ?? '',
          favoriteService: inject<FavoritesService>(),
        ),
        child: RestaurantDetailsScreen(
          restaurant: restaurant,
          imageNetwork: imageNetwork,
        ),
      );

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  int get reviewsCount => reviewsList.length;
  List<Review> get reviewsList => widget.restaurant.reviews ?? [];
  List<Widget> get reviews => List.generate(reviewsCount, (index) {
        final bool isFirstItem = index == 0;
        return RestaurantReviewWidget(imageNetwork: widget.imageNetwork, isFirstItem: isFirstItem, review: reviewsList[index]);
      });

  RestaurantDetailsViewModel? model;

  @override
  void initState() {
    super.initState();
    model = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await model!.load());
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();

    if (model!.status.isLoading) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          surfaceTintColor: RTColors.background,
          shadowColor: RTColors.primaryFill,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (model!.status.isError) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          surfaceTintColor: RTColors.background,
          shadowColor: RTColors.primaryFill,
        ),
        body: const RTErrorWidget(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        surfaceTintColor: RTColors.background,
        shadowColor: RTColors.primaryFill,
        title: Text(
          widget.restaurant.name ?? '',
          style: RTTextStyle.headingH6(),
        ),
        actions: [
          model!.status.isAddingFavorite
              ? const Padding(
                  padding: EdgeInsets.only(right: 14.0),
                  child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                )
              : IconButton(
                  icon: Icon(
                    (model!.isFavorite) ? Icons.favorite : Icons.favorite_border,
                    color: RTColors.primaryFill,
                  ),
                  onPressed: () => model!.toggleFavorite(),
                ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 360,
            child: Hero(
              tag: widget.restaurant.name ?? '',
              child: widget.imageNetwork.build(
                location: widget.restaurant.heroImage,
                errorWidget: const Icon(Icons.image_not_supported_rounded, size: 120),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.restaurant.price} ${widget.restaurant.displayCategory}',
                      style: RTTextStyle.caption(),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.restaurant.isOpen
                              ? AppLocalizations.of(context)!.restaurantListAllRestaurantsTabOpenNow
                              : AppLocalizations.of(context)!.restaurantListAllRestaurantsTabClosed,
                          style: RTTextStyle.overline(),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.restaurant.isOpen ? RTColors.open : RTColors.closed,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const _Divider(),
                Text(
                  AppLocalizations.of(context)!.restaurantDetailAddress,
                  style: RTTextStyle.caption(),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.restaurant.location?.formattedAddress ?? '',
                  style: RTTextStyle.body2(),
                ),
                const _Divider(),
                Text(
                  AppLocalizations.of(context)!.restaurantDetailOverallRating,
                  style: RTTextStyle.caption(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Text(
                        '${widget.restaurant.rating ?? 0.0}',
                        style: RTTextStyle.headingH4(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: SvgPicture.asset('assets/svg/star.svg'),
                      ),
                    ],
                  ),
                ),
                const _Divider(),
                Text(
                  AppLocalizations.of(context)!.restaurantDetailReviews(reviewsCount),
                  style: RTTextStyle.caption(),
                ),
                ...reviews,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: Divider(color: RTColors.dividerLine),
    );
  }
}
