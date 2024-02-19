import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/core/rt_colors.dart';
import 'package:restaurantour/core/rt_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:restaurantour/features/details/details_view_model.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/services/favorite_service.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  static Widget create({required String? restaurantId}) => ChangeNotifierProvider(
        create: (context) => DetailsViewModel(
          restaurantId: restaurantId ?? '',
          favoriteService: inject<FavoriteService>(),
        ),
        child: const DetailsScreen(),
      );

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final RTImageNetwork imageNetwork = inject<RTImageNetwork>();

  int get reviewsCount => reviewsList.length;
  List<Review> get reviewsList => model!.restaurant.reviews ?? [];
  Restaurant get restaurant => model!.restaurant;

  DetailsViewModel? model;

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
          model!.restaurant.name ?? '',
          style: RTTextStyle.headingH6(),
        ),
        actions: [
          model!.status.isAddingFavorite
              ? const Padding(
                  padding: EdgeInsets.only(right: 14.0),
                  child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                )
              : IconButton(
                  key: const Key('favorite-button'),
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
              tag: restaurant.name ?? '',
              child: imageNetwork.build(
                location: restaurant.heroImage,
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
                    Row(
                      children: [
                        Text(
                          restaurant.price ?? '',
                          style: RTTextStyle.caption(),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.displayCategory,
                          style: RTTextStyle.caption(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          restaurant.isOpen
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
                              color: restaurant.isOpen ? RTColors.open : RTColors.closed,
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
                  restaurant.location?.formattedAddress ?? '',
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
                        '${restaurant.rating ?? 0.0}',
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
                _Reviews(reviewsList: reviewsList),
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

class _Reviews extends StatefulWidget {
  final List<Review> reviewsList;

  const _Reviews({required this.reviewsList});
  @override
  State<_Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<_Reviews> {
  final RTImageNetwork imageNetwork = inject<RTImageNetwork>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.reviewsList.length, (index) {
        final bool isFirstItem = index == 0;
        return RTReviewWidget(imageNetwork: imageNetwork, isFirstItem: isFirstItem, review: widget.reviewsList[index]);
      }),
    );
  }
}
