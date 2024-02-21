class Utils {
  static int roundDoubleToInt(double? value) {
    if (value == null || value <= 0) {
      return 0;
    }
    return value.round();
  }
}
