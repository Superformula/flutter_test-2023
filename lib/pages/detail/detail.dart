import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/logic/logic.dart';
import 'package:restaurantour/models/models.dart';
import 'package:restaurantour/pages/detail/widgets/widgets.dart';
import 'package:restaurantour/pages/widgets/widgets.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant =
        GoRouterState.of(context).extra! as Restaurant;

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              restaurant.name!,
              style: GoogleFonts.lora(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (state.restaurants.contains(restaurant)) {
                    context
                        .read<FavoritesCubit>()
                        .removeFavorite(restaurant: restaurant);
                  } else {
                    context
                        .read<FavoritesCubit>()
                        .addFavorite(restaurant: restaurant);
                  }
                },
                icon: Icon(
                  state.restaurants.contains(restaurant)
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 350,
                  width: MediaQuery.sizeOf(context).width,
                  child: Hero(
                    tag: restaurant.id!,
                    child: Image.network(
                      restaurant.heroImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RestaurantInfoText(restaurant: restaurant),
                          const Spacer(),
                          Text(
                            restaurant.isOpen ? 'Open now' : 'Closed',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            backgroundColor:
                                restaurant.isOpen ? Colors.green : Colors.red,
                            radius: 4,
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      const Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        restaurant.location?.formattedAddress ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 48),
                      const Text(
                        'Overall Rating',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${restaurant.rating ?? "N/A"}',
                            style: GoogleFonts.lora(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      Text(
                        '${restaurant.reviews?.length ?? 0} Reviews',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (restaurant.reviews != null)
                        ...restaurant.reviews!.map(
                          (review) => Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  restaurant.reviews!.last != review ? 32 : 0,
                            ),
                            child: ReviewTile(review: review),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
