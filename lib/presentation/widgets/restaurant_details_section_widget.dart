import 'package:flutter/material.dart';

class RestaurantDetailsSectionWidget extends StatelessWidget {
  //
  const RestaurantDetailsSectionWidget(
    this.widget, {
    this.isLast = false,
    this.padding = 25,
    Key? key,
  }) : super(key: key);

  final Widget widget;
  final bool isLast;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: padding),
            child: widget,
          ),
          if (!isLast) const Divider(height: 2),
        ],
      ),
    );
  }
}
