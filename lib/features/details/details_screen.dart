import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/details/details_view_model.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';
import 'package:restaurantour/theme/theme.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});
  static String route = GoRouterConfig.details.name;
  static String restaurantIdParams = GoRouterConfig.details.params.first;

  static Widget create({required String? restaurantId}) => ChangeNotifierProvider(
        create: (context) => DetailsViewModel(
          restaurantId: restaurantId ?? '',
          restaurantRepository: inject<RestaurantRepository>(),
          favoriteService: inject<FavoriteService>(),
          eventBus: inject<EventBusService>(),
        ),
        child: const DetailsScreen(),
      );

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final RTImageNetwork imageNetwork = inject<RTImageNetwork>();

  int get reviewsCount => model!.reviews.length;
  List<ReviewDto> get reviewsList => model!.reviews;
  RestaurantDto get restaurant => model!.restaurant;

  DetailsViewModel? model;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    model = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await model!.load());
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    const spaceBeforeEndOfScroll = 50;
    if (scrollController.offset >= scrollController.position.maxScrollExtent - spaceBeforeEndOfScroll && !scrollController.position.outOfRange) {
      model!.paginateReviews();
    }
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();
    final theme = Theme.of(context).extension<RTThemeExtension>()!;

    if (model!.status.isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (model!.status.isError) {
      return Scaffold(
        appBar: AppBar(),
        body: const RTErrorWidget(),
      );
    }

    return Scaffold(
      appBar: AppBar(
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
                    color: theme.primaryFillColor,
                  ),
                  onPressed: () => model!.toggleFavorite(),
                ),
        ],
      ),
      body: ListView(
        controller: scrollController,
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
                              color: restaurant.isOpen ? theme.openColor : theme.closedColor,
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
                  AppLocalizations.of(context)!.restaurantDetailReviews(model!.totalReviews),
                  style: RTTextStyle.caption(),
                ),
                _Reviews(reviewsList: reviewsList, isPaginating: model!.status.isPaginating),
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
    final theme = Theme.of(context).extension<RTThemeExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Divider(color: theme.dividerLineColor),
    );
  }
}

class _Reviews extends StatefulWidget {
  final List<ReviewDto> reviewsList;
  final bool isPaginating;
  const _Reviews({required this.reviewsList, required this.isPaginating});
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
        return Column(
          children: [
            RTReviewWidget(imageNetwork: imageNetwork, isFirstItem: isFirstItem, review: widget.reviewsList[index]),
            if (index + 1 == widget.reviewsList.length)
              Visibility(
                visible: widget.isPaginating,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
