import 'package:flutter/material.dart';

class FetchErrorRestaurants extends StatelessWidget {
  const FetchErrorRestaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Error: Please check your internet connection.'),
          )
        ],
      ),
    );
  }
}
