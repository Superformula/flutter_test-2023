import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/theme/theme.dart';

Widget widgetBuilder(Widget child) {
  return MaterialApp(
    localizationsDelegates: localizationsDelegates,
    debugShowCheckedModeBanner: false,
    theme: RTThemeData.themeData,
    home: Scaffold(body: child),
  );
}

final localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
