
import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_color.dart';

class ReviewRowItemLoading extends StatelessWidget {
  final bool isLastComment;

  ReviewRowItemLoading(this.isLastComment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColor.placeHolder,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              height: 22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColor.placeHolder,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              height: 22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColor.placeHolder,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Row(
              children: [
                ClipOval(
                    child:Container(
                      width: 40,
                      height: 40,
                      color: AppColor.placeHolder,
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: 60,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColor.placeHolder,
                    ),
                  ),
                )
              ],
            ),
          ),
          if(!isLastComment) divider()
        ],
      ),
    );
  }

  divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Divider(color: AppColor.dividerLine,thickness: 1),
    );
  }
}
