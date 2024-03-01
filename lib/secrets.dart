import 'dart:convert';

import 'package:flutter/services.dart';

class Secrets {
  static Future<String> get apiKey async {
    final secretsJson = jsonDecode(
      await rootBundle.loadString('assets/secrets.json'),
    );
    return secretsJson['api_key'];
  }
}
