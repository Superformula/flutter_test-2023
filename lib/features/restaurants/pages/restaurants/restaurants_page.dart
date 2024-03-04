import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/details/details_screen.dart';
import 'package:restaurantour/features/restaurants/pages/restaurants/restaurants_page_view_model.dart';
import 'package:restaurantour/theme/theme.dart';

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
    final spaceBeforeEndOfScroll = RTSizesType.xxg.size;
    if (scrollController.offset >= scrollController.position.maxScrollExtent - spaceBeforeEndOfScroll && !scrollController.position.outOfRange) {
      model!.paginateRestaurants();
    }
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();

    if (model!.restaurantsStatus.isLoading) return const RTShimmerLoading();

    if (model!.restaurantsStatus.isError) return RTErrorWidget(onTryAgain: model!.loadRestaurants);

    if (model!.restaurantsStatus.isEmpty) return const RTEmptyWidget();

    return RefreshIndicator(
      onRefresh: model!.loadRestaurants,
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
                openDetails: () {
                  context.pushNamed(
                    DetailsScreen.route,
                    pathParameters: {DetailsScreen.restaurantIdParams: model!.restaurantsList[index].id ?? ''},
                  );
                },
              ),
              if (index + 1 == model!.restaurantsList.length)
                Visibility(
                  visible: model!.restaurantsStatus.isPaginating,
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
        },
      ),
    );
  }
}
