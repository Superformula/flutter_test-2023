extension IterableExtension<T> on Iterable<T>? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNotEmptyOrNull {
    return !this.isNullOrEmpty;
  }

  T? get firstOrNull {
    return this.isNotEmptyOrNull ? this!.first : null;
  }

  T? get lastOrNull {
    return this.isNotEmptyOrNull ? this!.last : null;
  }
}
