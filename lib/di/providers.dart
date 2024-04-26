part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<Dio>(
    create: (context) => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: {
          'Authorization': 'Bearer ${AppConstants.apiKey}',
          'Content-Type': 'application/graphql',
        },
      ),
    ),
  ),
];
