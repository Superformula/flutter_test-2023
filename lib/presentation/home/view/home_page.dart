import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/injection_container/config_dependencies.dart';
import 'package:restaurantour/presentation/home/home.dart';
import 'package:restaurantour/presentation/home/state_management/home_cubit/home_cubit.dart';
import 'package:restaurantour/presentation/home/state_management/home_tab_controller_cubit/home_tab_controller_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<HomeCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<HomeTabControllerCubit>(),
        ),
      ],
      child: const HomeView(),
    );
  }
}
