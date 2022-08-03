import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/ui/widgets/restaurant_price_and_category_widget.dart';
import '../../bloc/my_favorites/favorites_restaurants_bloc.dart';
import '../../bloc/my_favorites/favorites_restaurants_event.dart';
import '../../bloc/my_favorites/favorites_restaurants_state.dart';
import '../../models/restaurant.dart';
import '../widgets/rating_widget.dart';
import '../widgets/restaurant_details_section_widget.dart';
import '../widgets/restaurant_is_open_widget.dart';
import '../widgets/restaurant_reviews_widget.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({required this.restaurant, Key? key})
      : super(key: key);

  final Restaurant restaurant;

  bool get hasReview =>
      restaurant.reviews != null && restaurant.reviews!.isNotEmpty;

  bool get hasAddress =>
      restaurant.location?.formattedAddress != null &&
      restaurant.location!.formattedAddress!.isNotEmpty;

  static const titleStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'VelourRaw',
    fontWeight: FontWeight.w600,
  );

  static const addressTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    //
    final width = MediaQuery.of(context).size.width;
    final padding = width * 0.072;

    final image = LayoutBuilder(
      builder: (context, constraints) => Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(restaurant.heroImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    final restaurantPriceCategoryAndIsOpen = RestaurantDetailsSectionWidget(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RestaurantPriceAndCategoryWidget(restaurant),
          RestaurantIsOpenWidget(restaurant),
        ],
      ),
      padding: padding,
    );

    final restaurantAddress = RestaurantDetailsSectionWidget(
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: padding),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(hasAddress ? 'Address' : 'No address'),
            ),
          ),
          if (hasAddress)
            Row(
              children: [
                Flexible(
                  child: Text(
                    restaurant.location!.formattedAddress!,
                    style: addressTextStyle,
                    maxLines: 2,
                  ),
                ),
                Flexible(child: Container())
              ],
            ),
        ],
      ),
      padding: padding,
    );

    final restaurantRatingDetails = RestaurantDetailsSectionWidget(
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: padding / 2),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text('Overall Rating'),
            ),
          ),
          RatingWidget.detail(restaurant.rating),
        ],
      ),
      padding: padding,
    );

    final restaurantReviews = RestaurantReviewsWidget(
      restaurant,
      isLast: true,
      padding: padding,
    );

    final favoriteButton = BlocBuilder<FavoritesRestaurantsBloc, FavoritesRestaurantsState>(
      builder: (context, state) {
        var isFavorite = state.restaurants.any(
          (Restaurant _restaurant) => _restaurant.id == restaurant.id,
        );
        if (isFavorite) {
          return IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context
                .read<FavoritesRestaurantsBloc>()
                .add(RemoveFavoriteRestaurant(restaurant)),
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => context
                .read<FavoritesRestaurantsBloc>()
                .add(AddFavoriteRestaurant(restaurant)),
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(restaurant.name ?? '', style: titleStyle),
        actions: <Widget>[
          favoriteButton,
        ],
      ),
      body: ListView(
        children: [
          image,
          restaurantPriceCategoryAndIsOpen,
          restaurantAddress,
          restaurantRatingDetails,
          restaurantReviews,
        ],
      ),
    );
  }
}
