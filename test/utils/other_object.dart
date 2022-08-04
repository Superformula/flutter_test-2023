import 'dart:math';

import 'package:restaurantour/models/restaurant.dart';

class OtherObject {
  static T? withTheSameType<T extends Object>(T? obj) {
    if (obj == null) return throw ArgumentError('obj is $T and null');
    if (obj is bool) return !obj as T;
    if (obj is int) return (obj + 1) as T;
    if (obj is double) return (obj + 1) as T;
    if (obj is String) return (randomTxt()) as T;
    if (obj is Location) return Location(formattedAddress: randomTxt()) as T;

    if (obj is List<String>) {
      return <String>[randomTxt()] as T;
    }
    if (obj is List<Category>) {
      return <Category>[Category(alias: randomTxt(), title: randomTxt())] as T;
    }
    if (obj is List<Hours>) {
      return obj
          .map((Hours hour) => Hours(isOpenNow: !(hour.isOpenNow ?? true)))
          .toList() as T;
    }
    if (obj is List<Review>) {
      return <Review>[
        Review(
          user: User(id: randomTxt(), imageUrl: randomTxt(), name: randomTxt()),
          text: randomTxt(),
          id: randomTxt(),
          rating: randomInt(0, 5),
        )
      ] as T;
    }

    throw ArgumentError('${obj.runtimeType} is not supported');
  }

  static String randomTxt([int length = 10]) => _getRandomString(length);

  static double randomDouble([double min = 0.0, double max = 1.0]) =>
      min + (max - min) * Random().nextDouble();

  static int randomInt([int min = 0, int max = 100]) =>
      min + Random().nextInt(max - min);

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  static String _getRandomString(int length) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(Random.secure().nextInt(_chars.length)),
      ),
    );
  }
}
