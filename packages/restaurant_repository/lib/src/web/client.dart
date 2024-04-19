import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

// This allow us to add an analytics tool as FirebaseAnalytics/NewRelic
Client get webClient => InterceptedClient.build(
      interceptors: [],
      requestTimeout: const Duration(seconds: 15),
    );
