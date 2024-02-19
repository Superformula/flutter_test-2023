class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  toString() => message;
}
