import 'package:flutter/material.dart';
import 'package:restaurantour/detail_view/detail_view_main.dart';
import 'package:restaurantour/main_app.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String detailView = "/detail_view";

  static setUpRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      initialRoute: (context) => const MainApp(),
    };
  }

  static setUpGenerateRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case detailView:
            final arg = settings.arguments as DetailViewArgument;
            return DetailViewMain(arg.restaurant, arg.index);
          default:
            return const MainApp();
        }
      },
    );
  }
}
