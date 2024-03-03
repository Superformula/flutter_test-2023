import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

enum RTLoggerType {
  debug,
  error,
  info,
  log,
  warning,
}

extension RTLoggerTypeExt on RTLoggerType {
  String get icon => [
        '🐛', // Debug
        '🚨', // Error
        '💡', // Info
        '🪧', // Log
        '🚧', // Warning
      ][index];

  String get label => [
        'Debug',
        'Error',
        'Info',
        'Log',
        'Warning',
      ][index];

  String get _color => [
        "\u001b[32m", // Debug
        "\u001b[31m", // Error
        "\u001b[36m", // Info
        "\u001b[37m", // Log
        "\u001b[33m", // Warning
      ][index];

  String get _end => "\x1B[0m";

  void log(String message) => dev.log(_color + icon + ' ' + label + ': ' + message + _end);
}

class RTLogger {
  static void _log({
    required RTLoggerType type,
    required String message,
    Object? exception,
    Object? stackTrace,
    Object? extraData,
  }) {
    if (kDebugMode) {
      final exceptionText = exception != null ? '\nException:\n$exception' : '';
      final stackTraceText = stackTrace != null ? '\nStackTrace:\n$stackTrace' : '';
      final extraDataText = extraData != null ? '\nExtraData:\n$extraData' : '';
      type.log('$message $exceptionText $stackTraceText $extraDataText');
    }
  }

  static void d({required String message, Object? exception, Object? stackTrace, Object? extraData}) {
    _log(type: RTLoggerType.debug, message: message, exception: exception, stackTrace: stackTrace, extraData: extraData);
  }

  static void e({required String message, required Object exception, Object? stackTrace, Object? extraData}) {
    _log(type: RTLoggerType.error, message: message, exception: exception, stackTrace: stackTrace, extraData: extraData);
  }

  static void i({required String message, Object? extraData}) {
    _log(type: RTLoggerType.info, message: message, extraData: extraData);
  }

  static void l({required String message, Object? extraData}) {
    _log(type: RTLoggerType.log, message: message, extraData: extraData);
  }

  static void w({required String message, Object? extraData}) {
    _log(type: RTLoggerType.warning, message: message, extraData: extraData);
  }
}
