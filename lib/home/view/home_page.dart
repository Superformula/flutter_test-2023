import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static Route route() =>
      MaterialPageRoute(builder: (context) => const HomePage());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..loadAllRestaurants()
        ..loadFavorites(),
      child: const HomeView(),
    );
  }
}
