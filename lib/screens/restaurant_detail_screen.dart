import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/contants/text_style_constants.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/providers/favorite_restaurants_provider.dart';
import 'package:restaurantour/providers/fetch_restaurants_provider.dart';
import 'package:restaurantour/widgets/review_card_widget.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  const RestaurantDetailScreen({Key? key, required this.restaurantId})
      : super(key: key);

  final String restaurantId;

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  late List<ReviewCardWidget> reviews;
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    //Populate the reviews list
    reviews = [];
    final restaurants = ref.read(restaurantsNotifierProvider).asData?.value;
    Restaurant? restaurant;
    if (restaurants != null) {
      final restaurant = restaurants.firstWhere(
        (rest) => rest.id == widget.restaurantId,
        orElse: () => throw Exception(
            "Restaurant with ID ${widget.restaurantId} not found"),
      );
      if (restaurant.reviews != null) {
        populateReviewsList(restaurant.reviews!);
      }
    }

    if (restaurant != null) {
      isFavorite = ref.read(favoritesProvider).contains(restaurant);
      if (restaurant.reviews != null) {
        populateReviewsList(restaurant.reviews!);
      }
    }
  }

//Add or Remove to/from favorites
  void toggleFavorite(Restaurant restaurant) {
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
    if (isFavorite) {
      favoritesNotifier.removeFavorite(restaurant);
    } else {
      favoritesNotifier.addFavorite(restaurant);
    }
    setState(() {
      isFavorite = !isFavorite; // Toggle the favorite status in the UI
    });
  }

  //Populate Reviews List
  void populateReviewsList(List<Review> fetchedReviews) {
    for (Review review in fetchedReviews) {
      reviews.add(
        ReviewCardWidget(
          rating: review.rating,
          username: review.user?.name,
          userImgUrl: review.user?.imageUrl,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final restaurantState = ref.watch(restaurantsNotifierProvider);

    return restaurantState.when(
      loading: () => const CircularProgressIndicator(
        color: Colors.black,
      ),
      error: (error, _) => Text('Error: $error'),
      data: (restaurants) {
        final restaurant = restaurants.firstWhere(
          (rest) => rest.id == widget.restaurantId,
          orElse: () => throw Exception('Restaurant not found'),
        );
        return buildRestaurantDetails(restaurant);
      },
    );
  }

  Widget buildRestaurantDetails(Restaurant restaurant) {
    //Get overall rating
    double overallRating = 0;
    if (restaurant.reviews != null && restaurant.reviews!.isNotEmpty) {
      overallRating = restaurant.reviews!
              .map(
                (review) => review.rating!.toDouble(),
              )
              .reduce((a, b) => a + b) /
          restaurant.reviews!.length;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          restaurant.name ?? 'No restaurant name found',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {
              toggleFavorite(restaurant);
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 361,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  restaurant.heroImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${restaurant.price} ${restaurant.categories}',
                      style: TextStylesClass.priceCategoryTextStyle,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Open Now',
                          style: TextStylesClass.openCloseRestaurantTextStyle,
                        ),
                        const Gap(6),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                restaurant.isOpen ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(24),
                const Divider(),
                const Gap(24),
                Text(
                  'Address',
                  style: TextStylesClass.captionTextStyle,
                ),
                const Gap(24),
                Text(
                  restaurant.location?.formattedAddress ?? '',
                  style: TextStylesClass.restaurantAddressTextStyle,
                ),
                const Gap(24),
                const Divider(),
                const Gap(24),
                Text(
                  'Overall Rating',
                  style: TextStylesClass.captionTextStyle,
                ),
                const Gap(24),
                Row(
                  children: [
                    Text(
                      overallRating != 0 ? '$overallRating' : 'No Reviews',
                      style: GoogleFonts.lora(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
                const Gap(24),
                const Divider(),
                const Gap(24),
                Text(
                  '${reviews.length} Reviews',
                  style: TextStylesClass.captionTextStyle,
                ),
                const Gap(24),
                //show/loop through reviews - except the last one
                for (int i = 0; i < reviews.length - 1; i++) ...[
                  reviews[i],
                  const Divider(),
                ],

                //show the last review (without the divider at the end)
                reviews.isNotEmpty ? reviews.last : Container(),
                const Gap(100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
