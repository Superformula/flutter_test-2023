import 'package:flutter/material.dart';

class NoFavoritesData extends StatelessWidget {
  const NoFavoritesData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("No favorite data.")
        ],
      ),
    );
  }
}
