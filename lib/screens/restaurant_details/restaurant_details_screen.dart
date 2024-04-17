import 'package:flutter/material.dart';
import 'package:restaurantour/custom_widget/custom_app_bar.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({super.key});

  static void push(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RestaurantDetails()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context, "Details"),
      body: Container(),
    );
  }
}
