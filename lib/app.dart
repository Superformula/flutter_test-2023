import 'package:flutter/material.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/core/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:restaurantour/core/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final goRouter = inject<GoRouterConfig>();
    return MaterialApp.router(
      routerConfig: goRouter.router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: RTThemeData.themeData,
    );
  }
}
