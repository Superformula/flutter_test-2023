import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/injection_container/presentation/config_presentation.config.dart';

@InjectableInit(
  generateForDir: ['lib/presentation'],
  preferRelativeImports: false,
)
FutureOr<void> configurePresentationDependencies(
  GetIt getIt,
) =>
    $initGetIt(
      getIt,
    );
