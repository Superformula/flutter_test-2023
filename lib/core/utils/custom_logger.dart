import 'dart:developer';

import 'package:flutter/foundation.dart';

class LoggerApp {
  LoggerApp._();

  static void success(dynamic message) {
    if (message is! String) message = message.toString();
    log('\x1B[32m$message\x1B[0m', name: 'restaurant_app', time: DateTime.now());
  }

  static void info(dynamic message) {
    if (message is! String) message = message.toString();

    if (kDebugMode) {
      log('\x1B[34m$message\x1B[0m', name: 'restaurant_app', time: DateTime.now());
    }
  }

  static void error(dynamic message, [Object? exception, StackTrace? stackTrace]) {
    if (message is! String) message = message.toString();

    if (kDebugMode) {
      log('\x1B[31m$message\x1B[0m', name: 'restaurant_app', stackTrace: stackTrace, time: DateTime.now());
    }
  }

  static void warning(dynamic message) {
    if (message is! String) message = message.toString();
    if (kDebugMode) {
      log('\x1B[33m$message\x1B[0m', name: 'restaurant_app', time: DateTime.now());
    }
  }

  static void debug(dynamic message) {
    if (message is! String) message = message.toString();
    if (kDebugMode) log(message, name: 'restaurant_app', time: DateTime.now());
  }
}
