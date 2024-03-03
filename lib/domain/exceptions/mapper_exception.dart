class MapperException<From, To> implements Exception {
  final String message;

  MapperException(this.message);

  @override
  String toString() {
    return 'Error mapping from:$From to: $To message: $message';
  }
}
