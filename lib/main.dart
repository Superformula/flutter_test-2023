import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/pages/restaurants_page.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<RestaurantsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurantour',
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'Lora',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const RestaurantsPage(),
      ),
    );
  }
}
