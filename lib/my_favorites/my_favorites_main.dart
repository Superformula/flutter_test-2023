import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/common_widgets/restaurant_row_item.dart';
import 'package:restaurantour/my_favorites/no_favorites_data.dart';
import 'package:restaurantour/view_model/favorite_model.dart';

class MyFavoritesMain extends StatefulWidget {
  const MyFavoritesMain({Key? key}) : super(key: key);

  @override
  State<MyFavoritesMain> createState() => MyFavoritesMainState();
}

class MyFavoritesMainState extends State<MyFavoritesMain>
    with AutomaticKeepAliveClientMixin<MyFavoritesMain> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteModel>(
      builder: (context, favoriteModel, child) {
        return favoriteModel.favoriteRestaurants.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                itemCount: favoriteModel.favoriteRestaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  return RestaurantRowItem(
                    isLoading: false,
                    parentRoute: ParentRoute.myFavorite,
                    favoriteModel: favoriteModel,
                    theme: Theme.of(context),
                    restaurant: favoriteModel.favoriteRestaurants[index],
                    index: index,
                  );
                })
            : const NoFavoritesData();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
