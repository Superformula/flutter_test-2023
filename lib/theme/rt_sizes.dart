import 'package:restaurantour/core/core.dart';

/// Sizes available: XXXXS-1px, XXXS-2px, XXS-4px, XS-6px, S-8px, M-12px, L-14px, XL-16px, XXL-18px, XXXL-20px, G-24, XG-40px, XXG-50px, XXXG-80px, GG-88px, XGG-104px, XXGG-120px, XXXGG-140px, XXXXGG-300px, XXXXXGG-360px
enum RTSizesType {
  /// 1
  xxxxs,

  /// 2
  xxxs,

  /// 4
  xxs,

  /// 6
  xs,

  /// 8
  s,

  /// 12
  m,

  /// 14
  l,

  /// 16
  xl,

  /// 18
  xxl,

  /// 20
  xxxl,

  /// 24
  g,

  /// 40
  xg,

  /// 50
  xxg,

  /// 80
  xxxg,

  /// 88
  gg,

  /// 104
  xgg,

  /// 120
  xxgg,

  /// 140
  xxxgg,

  /// 300
  xxxxgg,

  /// 360
  xxxxxgg,
}

extension RTSizesTypeExt on RTSizesType {
  double get size => [
        1.0, // xxxxs
        2.0, // xxxs
        4.0, // xxs
        6.0, // xs
        8.0, // s
        12.0, // m
        14.0, // l
        16.0, // xl
        18.0, // xxl
        20.0, // xxxl
        24.0, // g
        40.0, // xg
        50.0, // xxg
        80.0, // xxxg
        88.0, // gg
        104.0, // xgg
        120.0, // xxgg
        140.0, // xxxgg,
        300.0, // xxxxgg,
        360.0, // xxxxxgg,
      ][index];

  Widget get spacer => SizedBox(height: size, width: size);

  Radius get radius => Radius.circular(size);
}
