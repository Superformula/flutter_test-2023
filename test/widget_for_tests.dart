import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Widget widgetBuilder(Widget child) {
  return MaterialApp(
    localizationsDelegates: localizationsDelegates,
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: child),
  );
}

final localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
