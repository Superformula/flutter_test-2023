class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  toString() => message;
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  toString() => message;
}

class ModelException implements Exception {
  final String message;

  ModelException(this.message);

  @override
  toString() => message;
}