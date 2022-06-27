import 'package:flutter/material.dart';
import 'package:restaurantour/detail_view/detail_view_app_bar.dart';

class DetailHeaderInheritedWidget extends InheritedWidget {
  final DetailViewAppBarState data;

  const DetailHeaderInheritedWidget(
      {required this.data, Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
