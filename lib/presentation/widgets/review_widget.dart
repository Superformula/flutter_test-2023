import 'package:flutter/material.dart';

import '../../models/restaurant.dart';
import '../../presentation/widgets/rating_widget.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget(
    this.review, {
    this.isLast = true,
    this.padding = 25,
    Key? key,
  }) : super(key: key);

  final Review review;
  final bool isLast;
  final double padding;

  bool get hasUser => review.user != null;

  bool get hasUserName => hasUser && userName.isNotEmpty;

  bool get hasUserImageUrl => hasUser && userImageUrl.isNotEmpty;

  double get rating => (review.rating ?? 0).toDouble();

  String get text => review.text ?? '';

  String get userImageUrl => review.user!.imageUrl ?? '';

  String get userName => review.user!.name ?? '';

  static const reviewTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    final reviewInformation = Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: padding / 2, top: padding / 2),
          child: Align(
            alignment: Alignment.topLeft,
            child: RatingWidget.simple(rating),
          ),
        ),
        Text(text, style: reviewTextStyle),
      ],
    );

    final userInformation = Padding(
      padding: EdgeInsets.only(top: padding / 1.2, bottom: padding / 2),
      child: Row(
        children: [
          if (hasUserImageUrl)
            CircleAvatar(
              radius: padding / 2,
              backgroundImage: NetworkImage(userImageUrl),
            ),
          if (hasUserName)
            Padding(
              child: Text(userName),
              padding: EdgeInsets.only(left: padding / 4),
            ),
        ],
      ),
    );

    return Column(
      children: [
        reviewInformation,
        if (hasUser) userInformation,
        if (!isLast) const Divider(height: 2),
      ],
    );
  }
}
