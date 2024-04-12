import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestaurantsListWidget extends StatefulWidget {
  bool favorites;
  RestaurantsListWidget({this.favorites = false});

  @override
  State<RestaurantsListWidget> createState() => _RestaurantsListWidgetState();
}

class _RestaurantsListWidgetState extends State<RestaurantsListWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
      ),
    );
  }
}
