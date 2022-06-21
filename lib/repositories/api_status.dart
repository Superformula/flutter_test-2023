class Success<T> {
  int? code;
  T response;
  Success({
    this.code,
    required this.response,
  });
}

class Failure {
  int code;
  Object errorResponse;
  Failure({
    required this.code,
    required this.errorResponse,
  });
}

// ignore_for_file: constant_identifier_names
const INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMATE = 102;
const UNKNOWN_ERROR = 103;
