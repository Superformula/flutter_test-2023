import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/app/data/services/network_info_service.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnection {}

void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoService service;
  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    service = NetworkInfoServiceInternetConnectionCheckerPlus(mockInternetConnectionChecker);
  });

  group('InternetConnectionChecker isConnected', () {
    test(
      'should forward the call to InternetConnectionChecker.hasConnection',
      () async {
        //arrange
        const tHasConnectionFuture = true;

        when(() => mockInternetConnectionChecker.hasInternetAccess)
            .thenAnswer((_) async => tHasConnectionFuture);

        //act
        final result = await service.isConnected();

        //assert
        verify(() => mockInternetConnectionChecker.hasInternetAccess);
        expect(result, tHasConnectionFuture);
      },
    );
    test(
      'should return false when catch an error from InternetConnectionChecker',
      () async {
        //arrange
        const tHasConnectionFuture = false;

        when(() => mockInternetConnectionChecker.hasInternetAccess)
            .thenThrow((_) async => Exception());

        //act
        final result = await service.isConnected();

        //assert
        verify(() => mockInternetConnectionChecker.hasInternetAccess);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
