import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/core/design_system/restaurantour_design_system.dart';
import 'package:restaurantour/core/design_system/widgets/open_status_widget.dart';
import 'package:restaurantour/core/design_system/widgets/rating_widget.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_details_state.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_details_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: restaurant.id ?? 'restaurant.heroImage',
              child: Image.network(
                restaurant.heroImage,
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(RestaurantourSizes.size5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: RestaurantourSizes.size3),
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
                  const SizedBox(height: RestaurantourSizes.size6),
                  const Divider(),
                  const SizedBox(height: RestaurantourSizes.size6),
                  Text(
                    AppLocalizations.of(context)!.address,
                    style: RestaurantourTextStyles.caption,
                  ),
                  const SizedBox(height: RestaurantourSizes.size6),
                  Text(
                    restaurant.location?.formattedAddress ?? '',
                    style: RestaurantourTextStyles.caption
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: RestaurantourSizes.size5),
                  const Divider(),
                  const SizedBox(height: RestaurantourSizes.size5),
                  Text(
                    AppLocalizations.of(context)!.overallRating,
                    style: RestaurantourTextStyles.caption,
                  ),
                  const SizedBox(height: RestaurantourSizes.size5),
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
                      const SizedBox(width: RestaurantourSizes.size2),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: RestaurantourSizes.size5,
                      ),
                    ],
                  ),
                  const SizedBox(height: RestaurantourSizes.size5),
                  const Divider(),
                  Text(
                    '${restaurant.reviews?.length ?? 0} ${AppLocalizations.of(context)!.reviews}',
                    style: RestaurantourTextStyles.caption,
                  ),
                  const SizedBox(height: RestaurantourSizes.size5),
                  ListView.builder(
                    itemCount: restaurant.reviews?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final review = restaurant.reviews![index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: RestaurantourSizes.size5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingWidget(rating: restaurant.rating ?? 0),
                            const SizedBox(height: RestaurantourSizes.size2),
                            Text(
                              review.text ?? 'Review Text',
                              maxLines: review.rating,
                              overflow: TextOverflow.ellipsis,
                              style: RestaurantourTextStyles.body1,
                            ),
                            const SizedBox(height: RestaurantourSizes.size3),
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
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
