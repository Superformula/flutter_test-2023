class APIStatus {
  int? code;
  Object response;

  APIStatus({this.code, required this.response});
}

class Success extends APIStatus {
  Success({int? code, required Object response})
      : super(code: code, response: response);
}

class Failure extends APIStatus {
  Failure({int? code, required Object response})
      : super(code: code, response: response);
}

/// Yelp API Errors
/// https://docs.developer.yelp.com/docs/api-errors
class APIError {
  static const FIELD_REQUIRED = 400;
  static const UNAUTHORIZED = 401;
  static const INTERNAL_SERVER_ERROR = 500;
}
