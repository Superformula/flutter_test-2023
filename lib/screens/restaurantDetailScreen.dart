import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/providers/restaurantProvider.dart';
import 'package:restaurantour/widgets/restaurantDetail/addressWidget.dart';
import 'package:restaurantour/widgets/myDivider.dart';
import 'package:restaurantour/widgets/restaurantDetail/ratingWidget.dart';
import 'package:restaurantour/widgets/restaurantDetail/restaurantStatus.dart';
import 'package:restaurantour/widgets/restaurantDetail/reviewWidget.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({Key? key, required this.restaurant})
      : super(key: key);

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);

    isFavorite = restaurantProvider.favorites.contains(widget.restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name ?? ''),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });

              restaurantProvider.toggleFavorite(
                widget.restaurant.id!,
                isFavorite,
              );

              final snackBar = SnackBar(
                content: Text(
                  isFavorite ? 'Saved as favorite' : 'Removed from favorites',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: isFavorite
                    ? const Color(0xCC5FC95F)
                    : const Color.fromRGBO(
                        252,
                        76,
                        76,
                        0.8,
                      ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          if (widget.restaurant.photos != null &&
              widget.restaurant.photos!.isNotEmpty)
            Image.network(
              widget.restaurant.photos!.first,
              width: double.infinity,
              height: 400.0,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurant.price ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      ' ${widget.restaurant.categories?.first.title ?? ''}',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                RestaurantStatus(
                    isOpen: widget.restaurant.hours != null &&
                        widget.restaurant.isOpen),
              ],
            ),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AddressWidget(
                address: widget.restaurant.location!.formattedAddress ?? ''),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RatingWidget(rating: widget.restaurant.rating!),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${widget.restaurant.reviews!.length} reviews',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
              ),
            ),
          ),
          if (widget.restaurant.reviews != null)
            Column(
              children: [
                for (var i = 0; i < widget.restaurant.reviews!.length; i++)
                  Column(
                    children: [
                      if (i > 0) myDivider(),
                      ReviewWidget(review: widget.restaurant.reviews![i]),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
