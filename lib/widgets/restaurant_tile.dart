import 'package:flutter/material.dart';

import 'restaurant_status_widget.dart';
import 'stars_widget.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterLogo(size: 52),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Restaurant Name Goes Here And Wraps 2 Lines",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "\$\$\$\$ Italian",
                    style: TextStyle(),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StarsWidget(starCount: 4),
                      RestaurantStatusWidget(status: RestaurantStatus.open),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
