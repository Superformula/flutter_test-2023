import 'package:flutter/material.dart';

import '../../models/restaurant.dart';

class RestaurantIsOpenWidget extends StatelessWidget {
  const RestaurantIsOpenWidget(
    this.restaurant, {
    Key? key,
  }) : super(key: key);

  final Restaurant restaurant;

  static const openOrClosedTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
  );

  static const _openTxt = 'Open now';
  static final _openColor = Colors.lightGreenAccent.shade700;

  static const _closedTxt = 'Closed';
  static const _closedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          restaurant.isOpen ? _openTxt : _closedTxt,
          style: openOrClosedTextStyle,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(
            Icons.circle,
            size: 11,
            color: restaurant.isOpen ? _openColor : _closedColor,
          ),
        ),
      ],
    );
  }
}
