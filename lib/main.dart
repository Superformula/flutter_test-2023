import 'package:flutter/material.dart';
import 'package:restaurantour/injection_container/config_dependencies.dart';
import 'package:restaurantour/presentation/app/router/app_router.dart';
import 'package:restaurantour/presentation/app/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/home/state_management/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const Restaurantour());
}

class Restaurantour extends StatefulWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  State<Restaurantour> createState() => _RestaurantourState();
}

class _RestaurantourState extends State<Restaurantour> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: MaterialApp.router(
        title: 'RestauranTour',
        theme: lightAppThemeData(),
        routerConfig: _appRouter.routes,
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: BlocBuilder<HomeCubit, PaginationState<Restaurant>>(
//           builder: (context, state) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Restaurantour'),
//                 ElevatedButton(
//                   child: const Text('Fetch Restaurants'),
//                   onPressed: () async {
//                     // final yelpRepo = YelpRepository();

//                     // try {
//                     //   final result = await yelpRepo.getRestaurants();
//                     //   if (result != null) {
//                     //     print('Fetched ${result.restaurants!.length} restaurants');
//                     //   } else {
//                     //     print('No restaurants fetched');
//                     //   }
//                     // } catch (e) {
//                     //   print('Failed to fetch restaurants: $e');
//                     // }
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
