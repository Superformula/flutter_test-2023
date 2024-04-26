import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:restaurantour/logic/logic.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/services/services.dart';
import 'package:restaurantour/utils/utils.dart';

part 'blocs.dart';
part 'mappers.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DependencyInjectorHelper(
      blocs: _blocs,
      providers: _providers,
      repositories: _repositories,
      child: child,
    );
  }
}
