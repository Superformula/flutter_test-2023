import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/presentation/restaurant_detail/mixins/restaurant_detail_mixin.dart';
import 'package:restaurantour/presentation/widgets/widgets.dart';

class RestaurantInfoCardWidget extends StatefulWidget {
  const RestaurantInfoCardWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantEntity? restaurant;

  @override
  State<RestaurantInfoCardWidget> createState() =>
      _RestaurantInfoCardWidgetState();
}

class _RestaurantInfoCardWidgetState extends State<RestaurantInfoCardWidget>
    with RestaurantDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 8,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      height: 106,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 1),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 88,
            width: 88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: widget.restaurant?.heroImage ?? '',
                child: Image.network(
                  widget.restaurant?.heroImage ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  widget.restaurant?.name ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${widget.restaurant?.price} ${widget.restaurant?.displayCategory}",
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    CustomRatingBarWidget(
                      rating: convertDoubleRatingToInt(
                        widget.restaurant?.rating ?? 0,
                      ),
                    ),
                    const Spacer(),
                    showBusinessHoursStatus(
                      widget.restaurant!.isOpen,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const BusinessHoursCircleStatusWidget(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
