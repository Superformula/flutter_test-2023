import 'package:flutter/material.dart';
import 'package:restaurantour/dependency_injection/di_locator.dart';
import 'package:restaurantour/design_system/open_status_indicator.dart';
import 'package:restaurantour/design_system/restaurant_address.dart';
import 'package:restaurantour/design_system/restaurant_details.dart';
import 'package:restaurantour/design_system/restaurant_rating.dart';
import 'package:restaurantour/design_system/restaurant_stars.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/presentation/restaurants/restaurant_detail/restaurant_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/presentation/utils/constants.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final RestaurantEntity restaurant;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailViewModel>(
      create: (context) =>
          locator<RestaurantDetailViewModel>()..init(restaurant),
      builder: (context, child) {
        return Consumer<RestaurantDetailViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  restaurant.name,
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // Navigate back to the previous page
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      viewModel.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      final priorStatus = viewModel.isFavorite;
                      // toggle the favorite status
                      viewModel.toggleFavorite();

                      // Show a snackbar to confirm the action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            priorStatus
                                ? 'Removed from favorites'
                                : 'Added to favorites',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // Display the hero image
                    Hero(
                      tag: restaurant.id,
                      child: Image.network(
                        restaurant.heroImage,
                        fit: BoxFit.cover,
                        height: 300,
                        width: double.infinity,
                      ),
                    ),
                    // Display the restaurant details
                    Padding(
                      padding: const EdgeInsets.all(Constants.detailSpacing),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RestaurantDetails(
                            price: restaurant.price,
                            category: restaurant.category,
                          ),
                          OpenStatusIndicator(isOpen: restaurant.isOpen),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.detailSpacing,
                      ),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    // Display Address
                    Padding(
                      padding: const EdgeInsets.all(Constants.detailSpacing),
                      child: RestaurantAddress(
                        address: restaurant.address,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.detailSpacing),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    // Display the restaurant rating
                    Padding(
                      padding: const EdgeInsets.all(
                        Constants.detailSpacing,
                      ),
                      child: RestaurantRating(
                        rating: restaurant.rating,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.detailSpacing),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Constants.detailSpacing),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${restaurant.reviews.length} Reviews',
                        ),
                      ),
                    ),
                    // Display the restaurant reviews
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.detailSpacing,
                      ),
                      child: Column(
                        children: restaurant.reviews
                            .map(
                              (review) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RestaurantStars(rating: restaurant.rating),
                                  const SizedBox(
                                      height: Constants.detailVerticalSpacing),
                                  Text(
                                    review.comment,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                      height: Constants.detailVerticalSpacing),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          review.author.profileImageUrl,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(review.author.name),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: Constants.detailVerticalSpacing,
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
