import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/helpers/favorites_helper.dart';
import 'package:restaurantour/main.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/providers/data_provider.dart';
import 'package:restaurantour/widgets/restaurant_card_widget.dart';

class RestaurantsListWidget extends StatefulWidget {
  bool favorites;
  RestaurantsListWidget({this.favorites = false});

  @override
  State<RestaurantsListWidget> createState() => _RestaurantsListWidgetState();
}

class _RestaurantsListWidgetState extends State<RestaurantsListWidget> {
  DataProvider dataProvider = DataProvider();
  FavoritesHelpers favoritesProvider = FavoritesHelpers();
  bool _isLoading = false;
  List<Restaurant> restaurants = [];
  List<String> favorites = [];

  Future<void> getInitData() async {
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
      restaurants = dataProvider.restaurants;
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    dataProvider = Provider.of<DataProvider>(
      context,
      listen: false,
    );
    favoritesProvider = Provider.of<FavoritesHelpers>(
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
                  itemBuilder: (context, index) => Card(
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
                              child: Image.network(
                                restaurants[index].heroImage,
                                fit: BoxFit.cover,
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
                                          restaurants[index].id! +
                                              restaurants[index].name!,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      Text(
                                        "${restaurants[index].price} ${restaurants[index].displayCategory}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: List.generate(
                                                    restaurants[index]
                                                        .rating!
                                                        .toInt(),
                                                    (index) => Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 15,
                                                        )).toList(),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    restaurants[index].isOpen
                                                        ? "Open now"
                                                        : " Closed",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 5,
                                                    ),
                                                    child: Icon(
                                                      Icons.circle,
                                                      color: restaurants[index]
                                                              .isOpen
                                                          ? Colors.greenAccent
                                                          : Colors.redAccent,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Consumer<FavoritesHelpers>(
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
                                              var _favorites = value.favorites;
                                              print(
                                                  "_Favorites: ${_favorites}");
                                              var isPinnk =
                                                  _favorites.indexOf(id) >= 0;
                                              print("ID: ${id}");
                                              print(
                                                  "_Favorites: ${_favorites}");
                                              print("IsPink: ${isPinnk}");
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
    ));
  }
}
