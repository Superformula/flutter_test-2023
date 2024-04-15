import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';
import 'package:restaurantour/logic/favourite_restaurants_bloc/favourite_restaurants_bloc.dart';
import 'package:restaurantour/logic/restaurant_reviews_cubit/restaurant_reviews_cubit.dart';
import 'package:restaurantour/presentation/common/column_loading_placeholder/column_loading_placeholder.dart';
import 'package:restaurantour/presentation/common/network_hero/network_image_hero.dart';
import 'package:restaurantour/presentation/views/restaurant_details/widgets/restaurant_data.dart';
import 'package:restaurantour/presentation/views/restaurant_details/widgets/review_list.dart';
import 'package:restaurantour/presentation/views/restaurant_details/widgets/spaced_divider.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantDetailsPage(this.restaurant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantReviewsCubit(
        yelpRepository: RepositoryProvider.of<YelpRepository>(context),
      )..loadReviews(restaurantId: restaurant.id ?? ""),
      child: RestaurantDetailsPageView(restaurant),
    );
  }
}

class RestaurantDetailsPageView extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantDetailsPageView(this.restaurant, {Key? key})
      : super(key: key);

  @override
  State<RestaurantDetailsPageView> createState() =>
      _RestaurantDetailsPageViewState();
}

class _RestaurantDetailsPageViewState extends State<RestaurantDetailsPageView> {
  List<Review> reviewList = [];
  int reviewCount = 0;
  late bool isFavourite;

  @override
  void initState() {
    final favRestBlocState =
        BlocProvider.of<FavouriteRestaurantsBloc>(context).state;
    if (favRestBlocState is! FavouriteRestaurantsData) {
      isFavourite = false;
    } else {
      final favIndex = favRestBlocState.restaurantsList.indexWhere(
        (element) => element.id == widget.restaurant.id,
      );

      isFavourite = favIndex != -1;
    }

    super.initState();
  }

  void onToggleFavourite() {
    if (isFavourite) {
      BlocProvider.of<FavouriteRestaurantsBloc>(context).add(
        UnfavRestaurant(
          restaurantId: widget.restaurant.id ?? "",
        ),
      );
    } else {
      BlocProvider.of<FavouriteRestaurantsBloc>(context).add(
        FavRestaurant(
          restaurant: widget.restaurant,
        ),
      );
    }
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.restaurant.name ?? "",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lora(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: onToggleFavourite,
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: BlocConsumer<RestaurantReviewsCubit, RestaurantReviewsState>(
        listener: (context, state) {
          if (state is RestaurantReviewsData) {
            setState(() {
              reviewList = state.reviewsList;
              reviewCount = state.reviewCount;
            });
          } else if (state is RestaurantReviewsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                elevation: 4,
                margin: const EdgeInsets.only(
                  bottom: 0.0,
                  right: 24,
                  left: 24,
                ),
                content: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 361.0,
                  width: double.infinity,
                  child: NetworkImageHero(
                    imageLink: widget.restaurant.heroImage,
                    heroId:
                        widget.restaurant.id ?? widget.restaurant.name ?? "",
                  ),
                ),
                const SizedBox(height: 24.0),
                RestaurantDetails(widget.restaurant),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: SpacedDivider(),
                ),
                if (state is RestaurantReviewsLoading)
                  const SizedBox(
                    child: ColumnLoadingPlaceholder(),
                  )
                else
                  ReviewList(reviewList, reviewCount),
                const SizedBox(height: 48.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
