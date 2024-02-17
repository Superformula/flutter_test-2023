import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Home/tabs/my_favorites_tab/view/my_favorites_tab.dart';
import 'package:restaurantour/Modules/Home/tabs/my_favorites_tab/viewmodel/my_favorites_viemodel.dart';
import 'package:restaurantour/Modules/Home/viewmodel/home_viewmodel.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_adapter.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_service.dart';

class MyFavoritesInjection extends StatelessWidget {
  const MyFavoritesInjection({Key? key, required this.homeViewmodel})
      : super(key: key);

  final HomeViewmodel homeViewmodel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyFavoritesViewmodel(
        homeViewmodel,
        SharedPreferencesService(
          SharedpreferencesAdapter(),
        ),
      ),
      child: const MyFavoritesTab(),
    );
  }
}
