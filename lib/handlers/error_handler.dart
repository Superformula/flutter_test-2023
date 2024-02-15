import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurantour/utils/strings.dart';

void registerErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('${details.exception}, ${details.stack}');
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint('$error, $stack');
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(AppStrings.uiErrorMessage),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
