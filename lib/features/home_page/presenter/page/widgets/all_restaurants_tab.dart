import 'package:flutter/material.dart';

class AllRestaurantsTab extends StatelessWidget {
  const AllRestaurantsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('All Restaurants'),
          ],
        ),
      ),
    );
  }
}
