import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/injection_container/domain/config_domain.config.dart';

@InjectableInit(
  generateForDir: ['lib/domain'],
  preferRelativeImports: false,
)
FutureOr<void> configureDomainDependencies(
  GetIt getIt,
) =>
    $initGetIt(
      getIt,
    );
