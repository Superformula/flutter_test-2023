/// Copyright 2022 - Superformula. All rights reserved.
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:restaurantour/providers/restaurantsprovider.dart';

/// A widget that displays Restaurant details in a SingleChildScrollView.
/// A widget that does not require mutable state.
/// Show all details of the selected Restaurant by calling the Provider
/// This Class is route from the All Restaurants/Favourite Restaurants
class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({Key? key}) : super(key: key);

  /// Generate the Widget to show details of the selected Restaurants.
  /// Use the Provider to get the Favourite Restaurants
  /// This Widget build various types of widgets for the UI
  /// Pass the BuildContext as a Parameter to the build method
  /// We can add/remove the favourite
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final resModel = Provider.of<RestaurantsProvider>(context);
    var restDetails = arguments["restaurant"];
    return Center(
      key: const Key("RestaurantDetails"),
      child: Column(children: [
        Flexible(
            child: resModel.isFirstLoading
                ? const Center(
                    child: SizedBox(
                        width: 50,
                        height: 50, //color: Colors.lightGreen,
                        child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black))),
                  )
                : Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      title: Text(restDetails.name),
                      actions: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                if (resModel.allFavouriteRestaurants[restDetails.id] == null) {
                                  resModel.addFavourateRestaurant(restDetails.id);
                                } else {
                                  resModel.removeFavourateRestaurant(restDetails.id);
                                }
                              },
                              child: Icon(resModel.allFavouriteRestaurants[restDetails.id] == null ? Icons.favorite_border : Icons.favorite),
                            )),
                      ],
                    ),
                    body: SingleChildScrollView(
                        child: Column(children: [
                      Container(
                        height: 361,
                        margin: const EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(image: NetworkImage(restDetails.heroImage), fit: BoxFit.fill),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                          ),
                          child: Column(children: [
                            Container(
                              height: 55,
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text(restDetails.price.toString()),
                                Row(children: [
                                  Text(
                                    restDetails.isOpen ? "Open Now " : "Closed ",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    ),
                                  ),
                                  restDetails.isOpen
                                      ? const Icon(
                                          Icons.circle_rounded,
                                          size: 10,
                                          color: Colors.green,
                                        )
                                      : const Icon(Icons.circle_rounded, size: 10, color: Colors.red)
                                ])
                              ]),
                            ),
                            const Divider(color: Colors.black),
                            Container(alignment: Alignment.centerLeft, height: 50, child: const Text("Address")),
                            Container(alignment: Alignment.centerLeft, height: 50, child: Text(restDetails.location.formattedAddress ?? "")),
                            const Divider(color: Colors.black),
                            Container(alignment: Alignment.centerLeft, height: 50, child: const Text("Overall Rating")),
                            Container(
                                alignment: Alignment.centerLeft,
                                height: 50,
                                child: Row(children: [
                                  Text(
                                    restDetails.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                      height: 25, alignment: Alignment.bottomLeft, child: const Icon(Icons.star, color: Colors.orange, size: 12))
                                ])),
                            const Divider(color: Colors.black),
                            Container(alignment: Alignment.centerLeft, height: 50, child: Text("${restDetails.reviews.length} Reviews")),
                            Column(
                                children: List.generate(restDetails.reviews.length, (index) {
                              var review = restDetails.reviews[index];
                              return Column(children: [
                                Row(
                                    children: List.generate(review.rating.round(), (rindex) {
                                  return const Icon(Icons.star, color: Colors.orange, size: 12);
                                })),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 45,
                                  child: const Text("Review not posted"),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 45,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                      review.user.imageUrl == null
                                          ? const Icon(Icons.account_circle, size: 40)
                                          : Container(
                                              height: 40, width: 40, //margin: const EdgeInsets.only(left: 5.0, right: 15.0, top: 10.0, bottom: 10.0),
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(25)),
                                                image: DecorationImage(image: NetworkImage(review.user.imageUrl), fit: BoxFit.fill),
                                              ),
                                            ),
                                      Text("  ${review.user.name}"),
                                    ])),
                                const Divider(color: Colors.black),
                              ]);
                            })), //child: Text("${restDetails.review} Reviews")
                          ]))
                    ])))),
      ]),
    );
  }
}
