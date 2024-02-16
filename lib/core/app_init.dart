import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';

class AppInit {
  static Future<void> initializeApp() async {
    await dotenv.load(fileName: ".env");
    await HiveHelper().init();
  }
}
