/// {@template api_exception}
/// Base exception for ApiClient.
/// {@endtemplate}
abstract class ApiException implements Exception {
  /// {@macro api_exception}
  const ApiException(this.error);

  /// Error originally thrown in the API layer.
  /// Passed through to be reported in the upper layer.
  final Object error;
}

/// {@template network_exception}
/// Umbrella for all the exceptions that can be thrown by the API.
/// {@endtemplate}
class NetworkException extends ApiException {
  /// {@macro network_exception}
  const NetworkException(super.error);

  @override
  String toString() => '[NetworkException] $error';
}

/// {@template bad_request_exception}
/// 400 Bad Request.
/// {@endtemplate}
class BadRequestException extends ApiException {
  /// {@macro bad_request_exception}
  const BadRequestException(super.error);

  @override
  String toString() => '[BadRequestException] $error';
}

/// {@template unauthorized_exception}
/// 401 Unauthorized.
/// {@endtemplate}
class UnauthorizedException extends ApiException {
  /// {@macro unauthorized_exception}
  const UnauthorizedException(super.error);

  @override
  String toString() => '[UnauthorizedException] $error';
}

/// {@template forbidden_exception}
/// 403 Forbidden.
/// {@endtemplate}
class ForbiddenException extends ApiException {
  /// {@macro forbidden_exception}
  const ForbiddenException(super.error);

  @override
  String toString() => '[ForbiddenException] $error';
}

/// {@template deserialization_exception}
/// [Exception] thrown when the object passed from API cannot be
/// deserialized in the expected way by the app.
/// {@endtemplate}
class DeserializationException extends ApiException {
  /// {@macro deserialization_exception}
  const DeserializationException(super.error);

  /// {@macro deserialization_exception}
  const DeserializationException.emptyResponseBody()
      : super('Empty response body');

  @override
  String toString() => '[DeserializationException] $error';
}
