class ServerException implements Exception{}

class ConnectionException implements Exception{
  final String message;
  ConnectionException(this.message);
}
