/// Copyright 2022 - Superformula. All rights reserved.
import "package:flutter/material.dart";

/// A widget that displays all Restaurants in a ListView.
/// A widget that does not require mutable state.
/// Show Restaurant minimal Information
class RestaurantListItem extends StatelessWidget{
  final String title,category,image,price;
  final double rating;
  final bool isOpen;
  final VoidCallback onTap;

  const RestaurantListItem({
    Key? key,
    required this.title,
    required this.category,
    required this.image,
    required this.price,
    required this.isOpen,
    required this.rating,
    required this.onTap,
   }) : super(key: key);

  /// Generate the Widget to show minimal Restaurant details.
  /// Use the Provider to get the Restaurant details from Yelp API
  /// This Widget build various types of widgets for the UI
  /// Pass the BuildContext as a Parameter to the build method
  /// Get the All Restaurants from the Provider State  - All Restaurants
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 88,
            width: 88,
            margin: const EdgeInsets.only(left: 5.0, right: 15.0, top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
            ),
          ),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 15.0, top: 10.0, bottom: 10.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      category,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    Text(price),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(
                          children: List.generate(rating.round(), (indexv) {
                            return const Icon(Icons.star, color: Colors.orange, size: 12);
                          })),
                      Row(children: [
                        Text(
                          isOpen ? "Open Now " : "Closed ",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                        isOpen
                            ? const Icon(
                          Icons.circle_rounded,
                          size: 10,
                          color: Colors.green,
                        )
                            : const Icon(Icons.circle_rounded, size: 10, color: Colors.red)
                      ])
                    ]),
                  ]))),
        ]),
      ),
      onTap: onTap,
    );
  }
}