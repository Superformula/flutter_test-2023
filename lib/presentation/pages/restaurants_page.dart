import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/presentation/widgets/restaurant_rating_widget.dart';

import '../../utils/typography/restaurantour_text_styles.dart';
import '../../business_logic/favorite/favorite_cubit.dart';
import '../../business_logic/favorite/favorite_state.dart';

class RestaurantPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  FavoriteCubit get favoriteCubit => context.read<FavoriteCubit>();

  void listener(BuildContext context, FavoriteState state) {
    if (state.status.isFavoriteSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You favorited this restaurant!'),
        ),
      );
    } else if (state.status.isRemoved) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You unfavorited this restaurant!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.restaurant.name ?? '',
          style: RestaurantourTextStyles.h6,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () =>
                favoriteCubit.favoriteRestaurant(widget.restaurant),
            icon: BlocConsumer<FavoriteCubit, FavoriteState>(
              bloc: favoriteCubit,
              listener: listener,
              builder: (context, state) {
                if (state.favorites
                    .any((element) => element.id == widget.restaurant.id)) {
                  return const Icon(Icons.favorite);
                } else {
                  return const Icon(Icons.favorite_border);
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 361,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.restaurant.heroImage,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 28.0,
                horizontal: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${widget.restaurant.price} ${widget.restaurant.displayCategory}',
                    style: RestaurantourTextStyles.caption,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.restaurant.isOpen ? 'Open now' : 'Closed',
                        style: RestaurantourTextStyles.overline,
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        height: 8.0,
                        width: 8.0,
                        decoration: BoxDecoration(
                          color: widget.restaurant.isOpen
                              ? Colors.green
                              : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFEEEEEE)),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 28.0,
                horizontal: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Addres',
                    style: RestaurantourTextStyles.caption,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    widget.restaurant.location?.formattedAddress ?? '',
                    style: RestaurantourTextStyles.address,
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFEEEEEE)),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 28.0,
                horizontal: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Overall Rating',
                    style: RestaurantourTextStyles.caption,
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${widget.restaurant.rating ?? 0}',
                        style: RestaurantourTextStyles.rating,
                      ),
                      const Icon(
                        Icons.star,
                        size: 12,
                        color: Color(0xFFFFB800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFEEEEEE)),
            Padding(
              padding: const EdgeInsets.only(
                top: 28.0,
                bottom: 16,
                left: 24.0,
                right: 24.0,
              ),
              child: Text(
                '${widget.restaurant.reviews?.length ?? 0} Reviews',
                style: RestaurantourTextStyles.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 16.0,
              ),
              child: ListView.builder(
                itemCount: widget.restaurant.reviews?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    StarRating(
                      color: const Color(0xFFFFB800),
                      rating: widget.restaurant.reviews
                              ?.elementAt(index)
                              .rating!
                              .toDouble() ??
                          0,
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.',
                      style: RestaurantourTextStyles.body,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            widget.restaurant.reviews
                                    ?.elementAt(index)
                                    .user!
                                    .imageUrl ??
                                'http://via.placeholder.com/200x150',
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          widget.restaurant.reviews
                                  ?.elementAt(index)
                                  .user
                                  ?.name ??
                              '',
                          style: RestaurantourTextStyles.caption,
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                    const Divider(color: Color(0xFFEEEEEE)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
