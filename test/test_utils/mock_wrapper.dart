import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:restaurantour/localization/localization.dart';

class MockWrapper extends StatelessWidget {
  final Widget child;
  final List<SingleChildWidget> mockProviders;
  const MockWrapper({
    required this.child,
    this.mockProviders = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget mockApp = MaterialApp(
      home: Scaffold(
        body: child,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => context.l10n.appTitle,
    );

    if (mockProviders.isNotEmpty) {
      mockApp = MultiBlocProvider(
        providers: mockProviders,
        child: mockApp,
      );
    }

    return mockApp;
  }
}
