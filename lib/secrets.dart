import 'dart:convert';

import 'package:flutter/services.dart';

class Secrets {
  Secrets._();

  static String resolvedApiKey = '';

  static Future<void> init() async {
    resolvedApiKey = await apiKey;
  }

  static Future<String> get apiKey async {
    final secretsJson = jsonDecode(
      await rootBundle.loadString('assets/secrets.json'),
    );
    return secretsJson['api_key'];
  }
}
