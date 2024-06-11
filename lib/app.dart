import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/controllers/home/home_cubit.dart';
import 'package:restaurantour/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomePage(),
        ),
      );
}
