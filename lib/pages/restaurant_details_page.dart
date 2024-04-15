import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/providers/data_provider.dart';
import 'package:restaurantour/providers/favorites_helper.dart';
import 'package:restaurantour/widgets/category_widget%20copy.dart';
import 'package:restaurantour/widgets/my_divider_widget.dart';
import 'package:restaurantour/widgets/opennow_widget.dart';
import 'package:restaurantour/widgets/review_widget.dart';

class RestaurantDetailsPage extends StatefulWidget {
  Restaurant restaurant;
  RestaurantDetailsPage({required this.restaurant});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  late DataProvider dataProvider;
  late FavoritesProvider favoritesProvider;
  bool _isFavorite = false;
  bool _isLoading = false;

  Future<void> getInitData() async {
    setState(() {
      _isLoading = true;
    });
    await favoritesProvider.getFavorites();
    print(favoritesProvider.favorites);

    setState(() {
      _isFavorite = favoritesProvider.favorites
          .any((element) => element == widget.restaurant.id);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    dataProvider = Provider.of<DataProvider>(
      context,
      listen: false,
    );
    favoritesProvider = Provider.of<FavoritesProvider>(
      context,
      listen: false,
    );
    getInitData();
    super.initState();
  }

  Future<void> changeFavorite(bool value, String id) async {
    print("Value: $value");
    !value
        ? await favoritesProvider.addFavorite(id)
        : await favoritesProvider.removeFavorite(id);
    getInitData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.restaurant.name ?? "",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          _isLoading
              ? const CircularProgressIndicator.adaptive()
              : IconButton(
                  onPressed: () =>
                      changeFavorite(_isFavorite, widget.restaurant.id ?? ""),
                  icon: Icon(
                    Icons.favorite,
                    color: _isFavorite ? Colors.pink : Colors.grey,
                  ))
        ],
      ),
      body: SafeArea(
          child: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                height: size.height * 0.45,
                width: size.width,
                child: Hero(
                  tag: widget.restaurant.id ?? "",
                  child: Image.network(
                    widget.restaurant.heroImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CategoryWidget(
                        text:
                            "${widget.restaurant.price} ${widget.restaurant.displayCategory}"),
                    OpenNowWidget(isOpen: widget.restaurant.isOpen),
                  ],
                ),
              ),
              const MyDivider(),
              Container(
                alignment: Alignment.centerLeft,
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: Text("Address"),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    widget.restaurant.location!.formattedAddress ?? "",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const MyDivider(),
              Container(
                alignment: Alignment.centerLeft,
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: Text("Overall Rating"),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.restaurant.rating.toString() ?? "",
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const MyDivider(),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: Text("${widget.restaurant.reviews!.length} Reviews"),
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      widget.restaurant.reviews!.length,
                      (index) => ReviewWidget(
                          review: widget.restaurant.reviews![index])),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
