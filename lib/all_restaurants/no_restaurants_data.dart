import 'package:flutter/material.dart';

class NoRestaurantsData extends StatelessWidget {
  const NoRestaurantsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("No restaurant data.")
        ],
      ),
    );
  }
}
