import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/injection_container/config_dependencies.dart';
import 'package:restaurantour/presentation/home/home.dart';
import 'package:restaurantour/presentation/home/state_management/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: const HomeView(),
    );
  }
}
