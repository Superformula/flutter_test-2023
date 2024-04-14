import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';
import 'package:restaurantour/logic/restaurant_reviews_cubit/restaurant_reviews_cubit.dart';
import 'package:restaurantour/presentation/common/column_loading_placeholder/column_loading_placeholder.dart';
import 'package:restaurantour/presentation/common/network_hero/network_image_hero.dart';
import 'package:restaurantour/presentation/views/restaurant/widgets/restaurant_data.dart';
import 'package:restaurantour/presentation/views/restaurant/widgets/review_list.dart';
import 'package:restaurantour/presentation/views/restaurant/widgets/spaced_divider.dart';

class RestaurantPage extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantPage(this.restaurant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantReviewsCubit(
        yelpRepository: RepositoryProvider.of<YelpRepository>(context),
      )..loadReviews(restaurantId: restaurant.id ?? ""),
      child: RestaurantPageView(restaurant),
    );
  }
}

class RestaurantPageView extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantPageView(this.restaurant, {Key? key}) : super(key: key);

  @override
  State<RestaurantPageView> createState() => _RestaurantPageViewState();
}

class _RestaurantPageViewState extends State<RestaurantPageView> {
  List<Review> reviewList = [];
  int reviewCount = 0;

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
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
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
          if (state is RestaurantReviewsLoading) {
            return const SizedBox(
              width: double.infinity,
              child: ColumnLoadingPlaceholder(),
            );
          }
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
                ReviewList(reviewList, reviewCount),
              ],
            ),
          );
        },
      ),
    );
  }
}
