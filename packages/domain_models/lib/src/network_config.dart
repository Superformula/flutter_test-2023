import 'package:equatable/equatable.dart';

class NetworkConfig extends Equatable {
  final String yelpBaseUrl;
  final String yelpGraphqlEndpoint;

  const NetworkConfig({
    required this.yelpBaseUrl,
    required this.yelpGraphqlEndpoint,
  });

  Uri get yelpUri => Uri.parse('$yelpBaseUrl/$yelpGraphqlEndpoint');

  @override
  List<Object?> get props => [yelpBaseUrl, yelpGraphqlEndpoint];
}
