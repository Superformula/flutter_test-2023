import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/injection_container/packages/packages_config_dependencies.config.dart';

/// Configures all third party dependencies.
///
/// {@macro app_environment}
@InjectableInit(
  generateForDir: ['lib/injection_container/packages/modules'],
  preferRelativeImports: false,
)
FutureOr<void> configurePackagesDependencies(
  GetIt getIt,
) =>
    $initGetIt(
      getIt,
    );
