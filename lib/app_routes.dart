import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/detail_view/detail_view_main.dart';
import 'package:restaurantour/main_app.dart';
import 'package:restaurantour/view_model/connectivity_model.dart';
import 'package:restaurantour/view_model/restaurant_model.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String detailView = "/detail_view";

  static setUpRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      initialRoute: (context) => mainAppRoute(),
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
            return mainAppRoute();
        }
      },
    );
  }

  static mainAppRoute() {
    return ChangeNotifierProvider(
      create: (_) => ConnectivityModel(),
      child: const MainApp(),
    );
  }
}
