import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TrSkeleton extends StatelessWidget {
  const TrSkeleton({
    Key? key,
    required this.height,
    required this.width,
    this.marginBottom = 0.0,
    this.borderRadius = 12.0,
  }) : super(key: key);

  final double height;
  final double width;
  final double marginBottom;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      width: width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
          height: height,
          width: width,
        ),
      ),
    );
  }
}
