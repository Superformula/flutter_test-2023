import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfoService {
  Future<bool> isConnected();
}

class NetworkInfoServiceInternetConnectionCheckerPlus implements NetworkInfoService {
  final InternetConnection internetConnection;

  NetworkInfoServiceInternetConnectionCheckerPlus(this.internetConnection);

  @override
  Future<bool> isConnected() async {
    try {
      return await internetConnection.hasInternetAccess;
    } catch (_) {
      return false;
    }
  }
}
