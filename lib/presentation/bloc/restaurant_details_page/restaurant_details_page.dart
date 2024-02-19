import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/presentation/bloc/favourite_restaurants_bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/favourite_restaurants_bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/favourite_restaurants_bloc/restaurants_state.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_event.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_state.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';
import 'package:restaurantour/presentation/bloc/reviews_bloc/review_state.dart';
import 'package:restaurantour/presentation/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:restaurantour/presentation/bloc/reviews_bloc/reviews_event.dart';
import 'package:restaurantour/presentation/pages/widgets/custom_progress_indicator.dart';
import 'package:restaurantour/presentation/pages/widgets/is_open_widget.dart';
import 'package:restaurantour/presentation/pages/widgets/rating_icon_widget.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final RestaurantEntity restaurantEntity;
  const RestaurantDetailsPage({Key? key, required this.restaurantEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RestaurantDetailsBloc _detailsBloc =
        BlocProvider.of<RestaurantDetailsBloc>(context);
    final FavouriteRestaurantsBloc _favouriteRestaurantsBloc =
        BlocProvider.of<FavouriteRestaurantsBloc>(context);
    final ReviewBloc _reviewsBloc = BlocProvider.of<ReviewBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          restaurantEntity.name,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          BlocBuilder(
              bloc: _favouriteRestaurantsBloc,
              builder: (context, fav) {
                List<RestaurantEntity> list = [];
                int count = 0;
                if (fav is FavouriteRestaurantsLoaded) {
                  list = [...fav.result];
                  for (var element in fav.result) {
                    if (element.id == restaurantEntity.id) {
                      count++;
                    }
                  }

                  return IconButton(
                    onPressed: () {
                      if (count == 0) {
                        list.add(restaurantEntity);
                      }else{
                        list.remove(restaurantEntity);
                      }
                      context
                          .read<FavouriteRestaurantsBloc>()
                          .add(OnAddToFavorite(list));
                    },
                    icon:  Icon(
                     list.contains(restaurantEntity) ? Icons.favorite : Icons.favorite_border_rounded,
                      color: Colors.black,
                    ),
                  );
                }
                return IconButton(
                  onPressed: () {
                    context
                        .read<FavouriteRestaurantsBloc>()
                        .add(OnAddToFavorite(list));
                  },
                  icon: const Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.black,
                  ),
                );
              }),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder(
        bloc: _detailsBloc,
        builder: (context, state) {
          if (state is RestaurantDetailsEmpty) {
            context
                .read<RestaurantDetailsBloc>()
                .add(OnRequestedRestaurantDetails(restaurantEntity.id));
            return Container();
          }
          if (state is RestaurantDetailsLoading) {
            return const Center(child: CustomProgressIndicator());
          }
          if (state is RestaurantDetailsLoadFail) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  key: Key('error'),
                  child: Text('Error'),
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                  onPressed: () => context
                      .read<RestaurantDetailsBloc>()
                      .add(OnRequestedRestaurantDetails(restaurantEntity.id)),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            );
          }
          if (state is RestaurantDetailsLoaded) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(restaurantEntity.photos.first),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '${restaurantEntity.price} - ${restaurantEntity.categories.first.title}',
                            ),
                            IsOpenWidget(
                              isOpen: restaurantEntity.isOpenNow ?? false,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text('Address'),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          state.result.address,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text('Overral Rating'),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              state.result.rating.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 238, 214, 2),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Text("${state.result.reviewCount} Reviews"),
                        BlocBuilder(
                          bloc: _reviewsBloc,
                          builder: (context, s) {
                            if (s is ReviewEmpty) {
                              context.read<ReviewBloc>().add(
                                    OnRequestedReviews(restaurantEntity.id),
                                  );
                              return Container();
                            }
                            if (s is ReviewLoading) {
                              return const Center(
                                child: CustomProgressIndicator(),
                              );
                            }

                            if (s is ReviewLoaded) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: s.result.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      RatingIcon(
                                        rating: s.result[index].rating,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        s.result[index].text,
                                        style: GoogleFonts.openSans(),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          s.result[index].user.imageUrl != ''
                                              ? CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    s.result[index].user
                                                        .imageUrl,
                                                  ),
                                                )
                                              : const CircleAvatar(),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            restaurantEntity
                                                .review[index].user.name,
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
