import 'package:flutter/material.dart';
import 'package:restaurantour/core/design_system/restaurantour_design_system.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRestaurantItemWidget extends StatelessWidget {
  const ShimmerRestaurantItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.all(RestaurantourSizes.size3),
        padding: const EdgeInsets.all(RestaurantourSizes.size5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(RestaurantourSizes.size3),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(RestaurantourSizes.size3),
              child: Container(
                width: RestaurantourSizes.size10,
                height: RestaurantourSizes.size10,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: RestaurantourSizes.size6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(RestaurantourSizes.size2),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      height: RestaurantourSizes.size6,
                    ),
                    const SizedBox(height: RestaurantourSizes.size2),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: RestaurantourSizes.size6,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(RestaurantourSizes.size2),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: RestaurantourSizes.size2),
                    Container(
                      width: RestaurantourSizes.size5,
                      height: RestaurantourSizes.size4,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(RestaurantourSizes.size2),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: RestaurantourSizes.size2),
                    Container(
                      width: RestaurantourSizes.size7,
                      height: RestaurantourSizes.size3,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(RestaurantourSizes.size2),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
