import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../pages/details_page.dart';
import '../pages/home_page.dart';

part 'router_service.gr.dart';

@AutoRouterConfig()
class RouterService extends _$RouterService {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: DetailsRoute.page),
      ];
}
