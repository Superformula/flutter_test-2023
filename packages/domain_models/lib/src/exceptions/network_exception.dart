class NetworkException implements Exception {
  final int statusCode;
  final String message;

  NetworkException({required this.statusCode, required this.message});
}