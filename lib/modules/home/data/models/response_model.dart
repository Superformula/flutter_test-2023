class ResponseModel<D extends dynamic, E extends dynamic> {
  final D? data;
  final E? error;
  final int? statusCode;

  ResponseModel({
    this.data,
    this.error,
    this.statusCode,
  });

  bool get isSuccess => data != null;
  bool get isError => error != null;
}
