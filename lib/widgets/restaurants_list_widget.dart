import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/pages/restaurant_details_page.dart';
import 'package:restaurantour/providers/favorites_helper.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/providers/data_provider.dart';
import 'package:restaurantour/widgets/category_widget%20copy.dart';
import 'package:restaurantour/widgets/opennow_widget.dart';

class RestaurantsListWidget extends StatefulWidget {
  bool favorites;
  RestaurantsListWidget({this.favorites = false});

  @override
  State<RestaurantsListWidget> createState() => _RestaurantsListWidgetState();
}

class _RestaurantsListWidgetState extends State<RestaurantsListWidget> {
  DataProvider dataProvider = DataProvider();
  FavoritesProvider favoritesProvider = FavoritesProvider();
  bool _isLoading = false;
  List<Restaurant> restaurants = [];
  List<String> favorites = [];

  Future<void> getInitData() async {
    if (!widget.favorites) {
      setState(() {
        _isLoading = true;
      });
      await favoritesProvider.getFavorites();
      var result = await dataProvider.getRestaurants();
      favorites = favoritesProvider.favorites;
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }

      setState(() {
        restaurants = !widget.favorites
            ? dataProvider.restaurants
            : dataProvider.restaurants
                .where((restaurant) => favoritesProvider.favorites
                    .any((element) => element == restaurant.id!))
                .toList();
      });

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        restaurants = dataProvider.restaurants
            .where((restaurant) => favoritesProvider.favorites
                .any((element) => element == restaurant.id!))
            .toList();
      });
    }
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
    if (widget.favorites) {
      getInitData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Center(
        child: _isLoading
            ? const CircularProgressIndicator.adaptive()
            : Container(
                // color: Colors.red,
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) => RestaurantDetailsPage(
                            restaurant: restaurants[index]),
                      ))
                          .then((value) {
                        if (widget.favorites) {
                          getInitData();
                        }
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerLeft,
                        height: size.height * 0.135,
                        width: size.width * 0.95,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Hero(
                                  tag: restaurants[index].id ?? "",
                                  child: Image.network(
                                    restaurants[index].heroImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              width: size.width * 0.28,
                              height: size.height * 0.15,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          // height: size.height * 0.05,
                                          child: Text(
                                            restaurants[index].name!,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        CategoryWidget(
                                            text:
                                                "${restaurants[index].price} ${restaurants[index].displayCategory}"),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: List.generate(
                                                      restaurants[index]
                                                          .rating!
                                                          .toInt(),
                                                      (index) => Icon(
                                                            Icons.star,
                                                            color:
                                                                Colors.yellow,
                                                            size: 15,
                                                          )).toList(),
                                                ),
                                              ),
                                              OpenNowWidget(
                                                  isOpen: restaurants[index]
                                                      .isOpen),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Consumer<FavoritesProvider>(
                                        builder: (context, value, child) {
                                          return GestureDetector(
                                            onTap: () => changeFavorite(
                                                value.favorites.any((element) =>
                                                    element ==
                                                    restaurants[index].id),
                                                restaurants[index].id ?? ""),
                                            child: Builder(
                                              builder: (context) {
                                                var id =
                                                    restaurants[index].id ?? "";
                                                var _favorites =
                                                    value.favorites;
                                                var isPinnk =
                                                    _favorites.indexOf(id) >= 0;
                                                return Icon(
                                                  Icons.favorite,
                                                  color: isPinnk
                                                      ? Colors.pink
                                                      : Colors.grey,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    ));
  }
}
