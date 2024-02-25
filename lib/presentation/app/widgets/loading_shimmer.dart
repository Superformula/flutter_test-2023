import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/constants/constants.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final colors = appTheme.colors;

    return Shimmer.fromColors(
      baseColor: Colors.grey[200] ?? colors.grey ?? Colors.grey,
      highlightColor: colors.white ?? Colors.white,
      child: Container(
        height: Spacing.xxxlg * Spacing.xxs,
        width: Spacing.xxxlg * Spacing.xxs,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
