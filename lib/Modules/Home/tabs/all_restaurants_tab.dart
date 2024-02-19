import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Details/view/detail_injection.dart';
import 'package:restaurantour/Modules/Details/view/detail_view.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/categorie_text.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/image_frame.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/is_open_label.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/price_text.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/rating_stars_icon.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/restaurant_card.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/title_text.dart';
import 'package:restaurantour/Modules/Home/viewmodel/home_state.dart';
import 'package:restaurantour/Modules/Home/viewmodel/home_viewmodel.dart';

class AllRestaurantsTab extends StatelessWidget {
  const AllRestaurantsTab({Key? key, required this.homeViewmodel})
      : super(key: key);
  final HomeViewmodel homeViewmodel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewmodel, HomeState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorState) {
          return Center(child: Text(state.message));
        }
        if (state is LoadedState) {
          return ListView.builder(
            itemCount: homeViewmodel.restaurants.restaurants!.length,
            padding: const EdgeInsets.only(top: 10),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailInjection(
                        restaurant:
                            homeViewmodel.restaurants.restaurants![index],
                        favoriteRestaurants: homeViewmodel.favoriteRestaurants,
                      ),
                    ),
                  )
                },
                child: RestaurantCard(
                  child: Row(
                    children: [
                      ImageFrame(
                        imageUrl: homeViewmodel
                            .restaurants.restaurants![index].photos![0],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                              text: homeViewmodel
                                  .restaurants.restaurants![index].name,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                PriceText(
                                  text: homeViewmodel
                                      .restaurants.restaurants![index].price,
                                ),
                                CategorieText(
                                    text: homeViewmodel
                                        .restaurants
                                        .restaurants![index]
                                        .categories?[0]
                                        .title)
                              ],
                            ),
                            Row(
                              children: [
                                RatingStarsIcon(
                                    amount: homeViewmodel.restaurants
                                        .restaurants![index].rating!),
                                Expanded(
                                  child: IsOpenLabel(
                                    isOpen: homeViewmodel
                                        .restaurants
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
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text("something went wrong, try again"),
        );
      },
    );
  }
}
