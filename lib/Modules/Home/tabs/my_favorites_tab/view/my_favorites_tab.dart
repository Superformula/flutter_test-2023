import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Details/view/detail_injection.dart';
import 'package:restaurantour/Modules/Home/tabs/my_favorites_tab/viewmodel/my_favorites_state.dart';
import 'package:restaurantour/Modules/Home/tabs/my_favorites_tab/viewmodel/my_favorites_viemodel.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/categorie_text.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/image_frame.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/is_open_label.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/price_text.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/rating_stars_icon.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/restaurant_card.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/title_text.dart';

class MyFavoritesTab extends StatelessWidget {
  const MyFavoritesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyFavoritesViewmodel myFavoritesViewmodel =
        BlocProvider.of<MyFavoritesViewmodel>(context);

    return BlocBuilder<MyFavoritesViewmodel, MyFavoritesState>(
      builder: (context, state) {
        if (state is InitialState) {
          myFavoritesViewmodel.fetchFavoriteRestaurants();
        }
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is LoadedState) {
          return myFavoritesViewmodel.favoriteRestaurants.restaurants != null
              ? ListView.builder(
                  itemCount: myFavoritesViewmodel
                      .favoriteRestaurants.restaurants!.length,
                  padding: const EdgeInsets.only(top: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailInjection(
                              restaurant: myFavoritesViewmodel
                                  .favoriteRestaurants.restaurants![index],
                              favoriteRestaurants: myFavoritesViewmodel
                                  .homeViewmodel.favoriteRestaurants,
                            ),
                          ),
                        ),
                      },
                      child: RestaurantCard(
                        child: Row(
                          children: [
                            ImageFrame(
                              imageUrl: myFavoritesViewmodel.favoriteRestaurants
                                  .restaurants![index].photos![0],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleText(
                                    text: myFavoritesViewmodel
                                        .favoriteRestaurants
                                        .restaurants![index]
                                        .name,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      PriceText(
                                        text: myFavoritesViewmodel
                                            .favoriteRestaurants
                                            .restaurants![index]
                                            .price,
                                      ),
                                      CategorieText(
                                        text: myFavoritesViewmodel
                                            .favoriteRestaurants
                                            .restaurants![index]
                                            .categories?[0]
                                            .title,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RatingStarsIcon(
                                        amount: myFavoritesViewmodel
                                            .favoriteRestaurants
                                            .restaurants![index]
                                            .rating!,
                                      ),
                                      Expanded(
                                        child: IsOpenLabel(
                                          isOpen: myFavoritesViewmodel
                                              .favoriteRestaurants
                                              .restaurants![index]
                                              .hours?[0]
                                              .isOpenNow,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text("Add restaurants to favorite"));
        }
        return const Center(
          child: Text("something went wrong, try again"),
        );
      },
    );
  }
}
