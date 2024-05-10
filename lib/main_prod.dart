import 'package:domain_models/domain_models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/start.dart';

void main() async {
  await dotenv.load(fileName: "assets/env/.env_prod");
  GetIt.instance.registerSingleton(
    const AppConfig(
      environemnt: Environment.prod,
      networkConfig: NetworkConfig(
        yelpBaseUrl: 'https://api.yelp.com',
        yelpGraphqlEndpoint: 'v3/graphql',
      ),
    ),
  );
  start();
}
