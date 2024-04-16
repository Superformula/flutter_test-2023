import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';

mixin RestaurantMixin {
  Widget showBusinessHoursStatus(bool isOpen) {
    if (isOpen) {
      return Text(
        AppWords.openNow,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 12,
        ),
      );
    }
    return Text(
      AppWords.closed,
      style: const TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 12,
      ),
    );
  }

  int convertDoubleRatingToInt(double rating) {
    var value = rating.round();
    return value;
  }

  String displayUserImage(List<ReviewEntity> reviewsList) {
    return reviewsList
        .map(
          (e) => e.user?.imageUrl ?? ImagePath.noPhotoUserAvatar,
        )
        .firstWhere(
          (url) => url.startsWith(RegExp(r'https?://')),
          orElse: () => ImagePath.noPhotoUserAvatar,
        );
  }

  String displayUserName(ReviewEntity review) {
    return review.user?.name ?? "";
  }

  String displayAddress(LocationEntity location) {
    return location.formattedAddress ?? AppWords.fakeAddress;
  }

  int displayReviewRating(ReviewEntity review) {
    return review.rating ?? 0;
  }
}
