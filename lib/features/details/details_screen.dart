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
    final spaceBeforeEndOfScroll = RTSizesType.xxg.size;
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
              ? Padding(
                  padding: EdgeInsets.only(right: RTSizesType.l.size),
                  child: SizedBox(
                    width: RTSizesType.xxl.size,
                    height: RTSizesType.xxl.size,
                    child: CircularProgressIndicator(strokeWidth: RTSizesType.xxxs.size),
                  ),
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
            height: RTSizesType.xxxxxgg.size,
            child: Hero(
              tag: restaurant.name ?? '',
              child: imageNetwork.build(
                location: restaurant.heroImage,
                errorWidget: Icon(Icons.image_not_supported_rounded, size: RTSizesType.xxgg.size),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(RTSizesType.g.size),
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
                        RTSizesType.xxs.spacer,
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
                        RTSizesType.s.spacer,
                        Padding(
                          padding: EdgeInsets.only(top: RTSizesType.xxxs.size),
                          child: Container(
                            width: RTSizesType.s.size,
                            height: RTSizesType.s.size,
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
                RTSizesType.g.spacer,
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
                  padding: EdgeInsets.only(top: RTSizesType.xl.size),
                  child: Row(
                    children: [
                      Text(
                        '${restaurant.rating ?? 0.0}',
                        style: RTTextStyle.headingH4(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: RTSizesType.m.size),
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
      padding: EdgeInsets.symmetric(vertical: RTSizesType.g.size),
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
                child: Padding(
                  padding: EdgeInsets.only(bottom: RTSizesType.m.size),
                  child: SizedBox(
                    height: RTSizesType.xxg.size,
                    width: RTSizesType.xxg.size,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
