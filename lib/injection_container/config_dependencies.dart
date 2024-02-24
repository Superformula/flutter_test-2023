import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:restaurantour/injection_container/presentation/config_presentation.dart';

import 'packages/packages_config_dependencies.dart';

final getIt = GetIt.I;

/// Configures all dependencies for packages external resources and data, domain and presentation internal
/// resources in that order.
Future<GetIt> configureDependencies() async {
  await configurePackagesDependencies(
    getIt,
  );
  await configurePresentationDependencies(
    getIt,
  );
  return getIt;
}
