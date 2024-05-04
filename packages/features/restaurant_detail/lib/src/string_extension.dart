extension StringExtension on String {
  /// This will search every instace of [%s] on the given string and replace it by the given [values].
  /// If the qunatity of [%s] is bigger than the values length, the method will throw a error.
  String format(List<String> values) {
    int count = 0;
    final result = replaceAllMapped('%s', (match) {
      final stringOnPosition = values[count];
      count++;
      return stringOnPosition;
    });
    return result;
  }
}
