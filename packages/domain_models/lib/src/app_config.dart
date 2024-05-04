import 'package:domain_models/src/environment.dart';
import 'package:domain_models/src/network_config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig extends Equatable {
  final Environment environemnt;
  final NetworkConfig networkConfig;

  String get yelpApiKey => dotenv.env['yelpApiKey']!;

  const AppConfig({
    required this.environemnt,
    required this.networkConfig,
  });

  @override
  List<Object?> get props => [environemnt, networkConfig];
}
