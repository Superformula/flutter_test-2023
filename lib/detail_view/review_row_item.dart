import 'package:flutter/material.dart';
import 'package:restaurantour/common_widgets/app_place_holder.dart';
import 'package:restaurantour/common_widgets/rating.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/place_holder_value.dart';
import 'package:restaurantour/theme/app_color.dart';

class ReviewRowItem extends StatelessWidget {
  final bool isLoading;
  final bool isLastComment;
  final ThemeData? theme;
  final Review? review;
  final int? index;

  const ReviewRowItem(
      {this.isLoading = false,
      this.isLastComment = false,
      this.theme,
      this.review,
      this.index,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? const AppPlaceHolder(
                  height: PlaceHolderValue.rateHeight,
                  width: PlaceHolderValue.rateWidth,
                )
              : Rating(review!.rating?.toDouble() ?? 0),
          Padding(
            padding: isLoading
                ? const EdgeInsets.only(top: 8.0)
                : const EdgeInsets.symmetric(vertical: 8.0),
            child: isLoading
                ? const AppPlaceHolder(height: PlaceHolderValue.normalHeight)
                : Text(
                    dummyReview(index!),
                    style: theme!.textTheme.bodyText1,
                  ),
          ),
          isLoading
              ? const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: AppPlaceHolder(height: PlaceHolderValue.normalHeight),
                )
              : Container(),
          Padding(
            padding: isLoading
                ? const EdgeInsets.only(top: 8.0)
                : const EdgeInsets.all(0),
            child: Row(
              children: [
                isLoading
                    ? ClipOval(
                        child: Container(
                        width: 40,
                        height: 40,
                        color: AppColor.placeHolder,
                      ))
                    : review!.user!.imageUrl != null
                        ? ClipOval(
                            child: Image.network(
                            review!.user!.imageUrl!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ))
                        : const Icon(Icons.account_circle,
                            color: Colors.grey, size: 46),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: isLoading
                      ? const AppPlaceHolder(
                          height: PlaceHolderValue.rateHeight,
                          width: PlaceHolderValue.rateWidth,
                        )
                      : Text(
                          review!.user?.name ?? "No Name",
                          style: theme!.textTheme.caption,
                        ),
                )
              ],
            ),
          ),
          if (!isLastComment) divider()
        ],
      ),
    );
  }

  divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Divider(color: AppColor.dividerLine, thickness: 1),
    );
  }

  String dummyReview(int index) {
    switch (index) {
      case 0:
        return "Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.";
      case 1:
        return "Review text goes here. Review text goes here. This is a review that is 2 lines long.";
      case 2:
        return "Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long.";
      default:
        return "No Review";
    }
  }
}
