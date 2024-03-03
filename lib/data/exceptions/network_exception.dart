class NetworkException implements Exception {
  final int statusCode;
  final String? message;

  NetworkException({required this.statusCode, this.message});

  @override
  String toString() =>
      'NetworkException: statusCode: $statusCode, message: $message';
}
