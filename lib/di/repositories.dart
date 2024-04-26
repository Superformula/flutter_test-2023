part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<YelpRepository>(
    create: (context) => YelpRepository(
      service: context.read<YelpService>(),
    ),
  ),
];
