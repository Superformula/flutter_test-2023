import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restaurantour/common/constants.dart';

import '../../../common/utils.dart';
import '../../../models/restaurant.dart';
import '../../../widgets/review_item_widget.dart';

class RestaurantDetailView extends StatefulWidget {
  final int restaurantIndex;
  final Restaurant restaurant;

  const RestaurantDetailView({
    Key? key,
    required this.restaurantIndex,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView> {
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final favorites = await Utils.loadFavorites();
    setState(() {
      isFavorite = favorites.any((r) => r.id == widget.restaurant.id);
    });
  }

  Future<void> _toggleFavorite() async {
    await Utils.toggleFavorite(widget.restaurant);
    _checkFavoriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: ListView(
        children: [
          Hero(
            tag: 'hero-restaurant-image-${widget.restaurantIndex}',
            child: Image.network(
              widget.restaurant.heroImage,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text('\$${widget.restaurant.price}'),
                const Gap(5),
                Text(widget.restaurant.displayCategory),
              ],
            ),
            trailing: widget.restaurant.isOpen
                ? SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          Constants.openNow,
                        ),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          Constants.closed,
                        ),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const Divider(),
          ListTile(
            title: const Text(Constants.address),
            subtitle: Text(widget.restaurant.location!.formattedAddress!),
          ),
          ListTile(
            title: const Text(Constants.overallRating),
            subtitle: Row(
              children: [
                Text(
                  widget.restaurant.rating.toString(),
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Icon(Icons.star, color: Colors.amber),
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: widget.restaurant.reviews?.length ?? 0,
              itemBuilder: (context, index) {
                var review = widget.restaurant.reviews?[index];
                if (review != null) {
                  return ReviewListTile(
                    stars: review.rating ?? 0,
                    reviewText: review.reviewText ?? Constants.reviewText,
                    userName: review.user?.name ?? Constants.anonymous,
                    userImageUrl:
                        review.user?.imageUrl ?? Constants.placeholder,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
