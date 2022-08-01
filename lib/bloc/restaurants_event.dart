abstract class RestaurantEvent {
  const RestaurantEvent();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantEvent && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class RestaurantStarted extends RestaurantEvent {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is RestaurantStarted &&
          runtimeType == other.runtimeType;

  // Following the convention:
  // You must override hashCode() in every class that overrides equals().
  // Failure to do so will result in a violation of the general contract for
  // Object.hashCode(), which will prevent your class from functioning properly
  // in conjunction with all hash-based collections, including HashMap,
  // HashSet, and Hashtable.
  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
