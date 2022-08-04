import 'dart:math';

class TestUtils {
  TestUtils._();

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
