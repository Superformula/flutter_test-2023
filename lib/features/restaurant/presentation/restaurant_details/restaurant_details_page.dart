import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/core/design_system/text_styles/restaurantour_text_styles.dart';
import 'package:restaurantour/core/design_system/widgets/open_status_widget.dart';
import 'package:restaurantour/core/design_system/widgets/rating_widget.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_detail_state.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_details_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant_detail';

  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant =
        ModalRoute.of(context)!.settings.arguments as Restaurant;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name ?? 'Restaurant Name',
          style: RestaurantourTextStyles.heading6,
        ),
        actions: [
          BlocProvider(
            create: (context) => GetIt.instance<RestaurantDetailCubit>()
              ..fetchRestaurantDetail(restaurant),
            child: BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
              builder: (context, state) {
                if (state is RestaurantDetailLoaded) {
                  return IconButton(
                    icon: Icon(
                      state.isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      context.read<RestaurantDetailCubit>().toggleFavorite();
                    },
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Hero(
            tag: restaurant.id ?? 'restaurant.heroImage',
            child: Image.network(
              restaurant.heroImage,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${restaurant.price ?? ''} ${restaurant.displayCategory}',
                      style: RestaurantourTextStyles.caption,
                    ),
                    OpenStatus(isOpen: restaurant.isOpen),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.address,
                  style: RestaurantourTextStyles.caption,
                ),
                const SizedBox(height: 24),
                Text(
                  restaurant.location?.formattedAddress ?? '',
                  style: RestaurantourTextStyles.caption
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.overallRating,
                  style: RestaurantourTextStyles.caption,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      '${restaurant.rating ?? 0}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lora',
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                Text(
                  '${restaurant.reviews?.length ?? 0} ${AppLocalizations.of(context)!.reviews}',
                  style: RestaurantourTextStyles.caption,
                ),
                const SizedBox(height: 16),
                Column(
                  children: restaurant.reviews?.map((review) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingWidget(rating: restaurant.rating ?? 0),
                              const SizedBox(height: 4),
                              Text(
                                review.id ?? 'Review ID',
                                maxLines: review.rating,
                                overflow: TextOverflow.ellipsis,
                                style: RestaurantourTextStyles.body1,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      review.user?.imageUrl ?? '',
                                    ),
                                    radius: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    review.user?.name ?? 'User Name',
                                    style: RestaurantourTextStyles.caption,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList() ??
                      [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
