import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/constants/text_style_constants.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/providers/favorite_restaurants_provider.dart';
import 'package:restaurantour/providers/fetch_restaurants_provider.dart';
import 'package:restaurantour/utils/rating_calculator.dart';
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
  // State variables
  late List<ReviewCardWidget> reviews;
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    initRestaurantDetails(); // Fetch and process restaurant details
  }

  // Fetches and processes restaurant details
  void initRestaurantDetails() async {
    reviews = []; //variable where the reviews will be managed
    final restaurants = ref.read(restaurantsNotifierProvider).asData?.value;
    // Check if restaurants data is available
    if (restaurants != null) {
      // Find restaurant by ID
      final restaurant = restaurants
          .firstWhereOrNull((rest) => rest.id == widget.restaurantId);
      if (restaurant != null) {
        // Check favorite status
        isFavorite = ref.read(favoritesProvider).contains(restaurant);
        if (restaurant.reviews != null) {
          populateReviewsList(restaurant.reviews!); // Populate reviews list
        }
      } else {
        throw Exception("Restaurant with ID ${widget.restaurantId} not found");
      }
    }
  }

  // Toggles restaurant as favorites
  void toggleFavorite(Restaurant restaurant) {
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
    if (isFavorite) {
      favoritesNotifier.removeFavorite(restaurant);
    } else {
      favoritesNotifier.addFavorite(restaurant);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  // Populates the reviews list with ReviewCardWidget widgets
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
      // Handle loading state
      loading: () => const CircularProgressIndicator(
        color: Colors.black,
      ),
      // Handle error state
      error: (error, _) => Text('Error: $error'),
      // Handle data state
      data: (restaurants) {
        final restaurant = restaurants
            .firstWhereOrNull((rest) => rest.id == widget.restaurantId);
        if (restaurant == null) {
          return const Text("Restaurant not found");
        }
        return buildRestaurantDetails(restaurant);
      },
    );
  }

  // Builds the UI for the restaurant details screen
  Widget buildRestaurantDetails(Restaurant restaurant) {
    //Obtain the overall rating for the current restaurant
    double overallRating =
        RatingCalculator.calculateAverageRating(restaurant.reviews!);

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
        centerTitle: false,
        title: Text(
          restaurant.name ?? 'No restaurant name found',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () => toggleFavorite(restaurant),
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
                image: restaurant.heroImage.isNotEmpty
                    ? NetworkImage(
                        restaurant.heroImage,
                      )
                    : const AssetImage('assets/img/no_image_available.png')
                        as ImageProvider,
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
                      '${restaurant.price ?? 'N/A'} ${restaurant.categories?.isNotEmpty == true ? restaurant.categories!.first.title : 'N/A'}',
                      style: TextStylesClass.priceCategoryTextStyle,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          restaurant.isOpen == true ? 'Open Now' : 'Closed',
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
                  restaurant.location?.formattedAddress ??
                      'No addressed provided',
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
                      //Check if there are any reviews
                      (overallRating != 0.0 && restaurant.reviews!.isNotEmpty)
                          ? '$overallRating'
                          : 'No Reviews',
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
