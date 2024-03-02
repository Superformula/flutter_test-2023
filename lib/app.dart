import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/theme/theme.dart';

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
