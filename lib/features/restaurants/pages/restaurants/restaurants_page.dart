import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/details/details_screen.dart';
import 'package:restaurantour/features/restaurants/restaurants_view_model.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({super.key});

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  RestaurantsViewModel? model;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    model = context.read();
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
      model!.paginateRestaurants();
    }
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();

    if (model!.restaurantsStatus.isLoading) return const RTShimmerLoading();

    if (model!.restaurantsStatus.isError) return RTErrorWidget(onTryAgain: () => model!.load());

    if (model!.restaurantsStatus.isEmpty) return const RTEmptyWidget();

    return RefreshIndicator(
      onRefresh: () => model!.load(),
      child: ListView.builder(
        controller: scrollController,
        itemCount: model!.restaurantsList.length,
        itemBuilder: (context, index) {
          final isFirstItem = index == 0;
          return Column(
            children: [
              RTItemWidget(
                key: Key('restaurant-$index'),
                isFirstItem: isFirstItem,
                imageNetwork: inject<RTImageNetwork>(),
                restaurant: model!.restaurantsList[index],
                openDetails: () async {
                  await context.pushNamed(
                    DetailsScreen.route,
                    pathParameters: {DetailsScreen.restaurantIdParams: model!.restaurantsList[index].id ?? ''},
                  );
                },
                onFinishNavigation: () => model!.loadFavorites(),
              ),
              if (index + 1 == model!.restaurantsList.length)
                Visibility(
                  visible: model!.restaurantsStatus.isPaginating,
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
        },
      ),
    );
  }
}
