import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/details/details_screen.dart';
import 'package:restaurantour/features/restaurants/pages/favorites/favorites_page_view_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoritesViewModel? model;

  @override
  void initState() {
    super.initState();
    model = context.read();
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();

    if (model!.status.isLoading) return const RTShimmerLoading();

    if (model!.status.isError) return const RTErrorWidget();

    if (model!.status.isEmpty) return const RTEmptyWidget();

    return ListView.builder(
      itemCount: model!.favoritesRestaurantList.length,
      itemBuilder: (context, index) {
        final isFirstItem = index == 0;

        return RTItemWidget(
          key: Key('favorite-restaurant-$index'),
          isFirstItem: isFirstItem,
          imageNetwork: inject<RTImageNetwork>(),
          restaurant: model!.favoritesRestaurantList[index],
          openDetails: () => context.pushNamed(
            DetailsScreen.route,
            pathParameters: {
              DetailsScreen.restaurantIdParams: model!.favoritesRestaurantList[index].id ?? '',
            },
          ),
        );
      },
    );
  }
}
