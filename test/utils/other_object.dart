import 'dart:math';

import 'package:restaurantour/models/restaurant.dart';

import 'test_utils.dart';

class OtherObject {
  static T? withTheSameType<T extends Object>(T? obj) {
    if (obj == null) return throw ArgumentError('obj is $T and null');
    if (obj is bool) return !obj as T;
    if (obj is int) return (obj + 1) as T;
    if (obj is double) return (obj + 1) as T;
    if (obj is String) return (TestUtils.randomTxt()) as T;
    if (obj is Location) {
      return Location(formattedAddress: TestUtils.randomTxt()) as T;
    }

    if (obj is List<String>) {
      return <String>[TestUtils.randomTxt()] as T;
    }
    if (obj is List<Category>) {
      return <Category>[
        Category(alias: TestUtils.randomTxt(), title: TestUtils.randomTxt())
      ] as T;
    }
    if (obj is List<Hours>) {
      return obj
          .map((Hours hour) => Hours(isOpenNow: !(hour.isOpenNow ?? true)))
          .toList() as T;
    }
    if (obj is List<Review>) {
      return <Review>[
        Review(
          user: User(
              id: TestUtils.randomTxt(),
              imageUrl: TestUtils.randomTxt(),
              name: TestUtils.randomTxt()),
          text: TestUtils.randomTxt(),
          id: TestUtils.randomTxt(),
          rating: TestUtils.randomInt(0, 5),
        )
      ] as T;
    }

    throw ArgumentError('${obj.runtimeType} is not supported');
  }
}
