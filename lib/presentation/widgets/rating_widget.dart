import 'package:flutter/material.dart';

enum _DisplayMode {
  simple,
  detail,
}

class RatingWidget extends StatelessWidget {
  //
  const RatingWidget.simple(double? rating, {Key? key})
      : rating = rating ?? 0,
        displayMode = _DisplayMode.simple,
        super(key: key);

  const RatingWidget.detail(double? rating, {Key? key})
      : rating = rating ?? 0,
        displayMode = _DisplayMode.detail,
        super(key: key);

  final double rating;
  final _DisplayMode displayMode;

  static const detailTextStyle = TextStyle(
    fontSize: 30,
    fontFamily: 'VelourRaw',
    fontWeight: FontWeight.w600,
    letterSpacing: -2,
  );

  static const starIcon = Icon(Icons.star, size: 17, color: Colors.amber);

  @override
  Widget build(BuildContext context) {
    switch (displayMode) {
      case _DisplayMode.simple:
        return Row(
          children: [for (var i = 0; i < rating.roundToDouble(); i++) starIcon],
        );
      case _DisplayMode.detail:
        return Row(
          children: [Text(rating.toString(), style: detailTextStyle), starIcon],
        );
      default:
        return Container();
    }
  }
}
