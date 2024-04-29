part of 'dependency_injector.dart';

final List<BlocProvider> _blocs = [
  BlocProvider<FavoritesCubit>(
    create: (context) => FavoritesCubit(),
  ),
];
