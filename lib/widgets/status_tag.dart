import 'package:flutter/material.dart';
import 'package:restaurantour/resources/resources_exports.dart';

class StatusTag extends StatelessWidget {
  final bool isOpen;
  final TextStyle? style;
  const StatusTag({Key? key, this.isOpen = false, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(isOpen ? AppStrings.isOpen : AppStrings.isClosed, style: style),
        SizedBox(width: AppSize.size4.w),
        Icon(
          Icons.circle,
          size: AppSize.size8,
          color: isOpen ? ColorManager.success : ColorManager.error,
        ),
      ],
    );
  }
}
