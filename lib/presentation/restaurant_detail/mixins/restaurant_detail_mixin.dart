import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';

mixin RestaurantDetailMixin {
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

  String displayUserImage(ReviewEntity reviewEntity) {
    final imageUrl = reviewEntity.user?.imageUrl;

    return imageUrl != null && imageUrl.startsWith(RegExp(r'https?://'))
        ? imageUrl
        : ImagePath.noPhotoUserAvatar;
  }

  String displayUserName(ReviewEntity review) {
    return review.user?.name ?? "";
  }

  String displayAddress(RestaurantEntity? restaurantEntity) {
    return restaurantEntity?.location?.formattedAddress ?? AppWords.fakeAddress;
  }

  int displayReviewRating(ReviewEntity review) {
    return review.rating ?? 0;
  }
}
