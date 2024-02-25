import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockDio extends Mock implements Dio {}

class _MockResponse<T> extends Mock implements Response<T> {}

void main() {
  group('ApiClient', () {
    late ApiClient apiClient;
    late Dio httpClient;
    late Response<dynamic> response;
    const fakeBaseUrl = 'http://baseUrl';
    const fakeResponseData = {'key': 'value'};

    setUp(() {
      httpClient = _MockDio();
      apiClient = ApiClient(httpClient: httpClient);
      response = _MockResponse();

      when(() => httpClient.options).thenReturn(
        BaseOptions(baseUrl: fakeBaseUrl),
      );
    });

    test('can be instantiated', () {
      when(() => httpClient.interceptors).thenReturn(
        Interceptors(),
      );

      expect(
        ApiClient(
          httpClient: httpClient,
        ),
        isNotNull,
      );
      expect(
        ApiClient(
          httpClient: httpClient,
          interceptors: [LoggingInterceptor()],
        ),
        isNotNull,
      );
    });

    group('get', () {
      group('throws', () {
        void setUpHttpError(int errorCode) {
          when(
            () => httpClient.get<dynamic>(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException.badResponse(
              statusCode: errorCode,
              requestOptions: RequestOptions(),
              response: Response(
                statusCode: errorCode,
                requestOptions: RequestOptions(),
              ),
            ),
          );
        }

        test(
            'expected BadRequestException '
            'on 400 response', () async {
          setUpHttpError(400);
          expect(
            apiClient.get<dynamic>(''),
            throwsA(isA<BadRequestException>()),
          );
        });

        test(
            'expected UnauthorizedException '
            'on 401 response', () async {
          setUpHttpError(401);
          expect(
            apiClient.get<dynamic>(''),
            throwsA(isA<UnauthorizedException>()),
          );
        });

        test(
            'expected ForbiddenException '
            'on 403 response', () async {
          setUpHttpError(403);
          expect(
            apiClient.get<dynamic>(''),
            throwsA(isA<ForbiddenException>()),
          );
        });

        test(
            'expected NetworkException '
            'on other response', () async {
          setUpHttpError(-1);
          expect(
            apiClient.get<dynamic>(''),
            throwsA(isA<NetworkException>()),
          );
        });
      });

      test(
          'returns data if response is successful '
          'with request headers', () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn(fakeResponseData);

        when(
          () => httpClient.get<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.get<dynamic>(
          '',
          headers: {'key': 'value'},
        );
        expect(
          data,
          equals(fakeResponseData),
        );
      });

      test('returns data if response is successful (200 with non-empty data)',
          () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn(fakeResponseData);

        when(
          () => httpClient.get<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.get<dynamic>('');
        expect(
          data,
          equals(fakeResponseData),
        );
      });

      test('returns data if response is successful (204 with empty data)',
          () async {
        when(() => response.statusCode).thenReturn(204);
        when(() => response.data).thenReturn(null);

        when(
          () => httpClient.get<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.get<dynamic>('');
        expect(
          data,
          equals(null),
        );
      });
    });

    group('post', () {
      group('throws', () {
        void setUpHttpError(int errorCode) {
          when(
            () => httpClient.post<dynamic>(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException.badResponse(
              statusCode: errorCode,
              requestOptions: RequestOptions(),
              response: Response(
                statusCode: errorCode,
                requestOptions: RequestOptions(),
              ),
            ),
          );
        }

        test(
            'expected BadRequestException '
            'on 400 response', () async {
          setUpHttpError(400);
          expect(
            apiClient.post<dynamic>(''),
            throwsA(isA<BadRequestException>()),
          );
        });

        test(
            'expected UnauthorizedException '
            'on 401 response', () async {
          setUpHttpError(401);
          expect(
            apiClient.post<dynamic>(''),
            throwsA(isA<UnauthorizedException>()),
          );
        });

        test(
            'expected ForbiddenException '
            'on 403 response', () async {
          setUpHttpError(403);
          expect(
            apiClient.post<dynamic>(''),
            throwsA(isA<ForbiddenException>()),
          );
        });

        test(
            'expected NetworkException '
            'on other response', () async {
          setUpHttpError(-1);
          expect(
            apiClient.post<dynamic>(''),
            throwsA(isA<NetworkException>()),
          );
        });
      });

      test(
          'returns data if response is successful '
          'with request headers', () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn(fakeResponseData);

        when(
          () => httpClient.post<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.post<dynamic>(
          '',
          headers: {'key': 'value'},
        );
        expect(
          data,
          equals(fakeResponseData),
        );
      });

      test('returns data if response is successful (200 with non-empty data)',
          () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn(fakeResponseData);

        when(
          () => httpClient.post<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.post<dynamic>('');
        expect(
          data,
          equals(fakeResponseData),
        );
      });

      test('returns data if response is successful (204 with empty data)',
          () async {
        when(() => response.statusCode).thenReturn(204);
        when(() => response.data).thenReturn(null);

        when(
          () => httpClient.post<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.post<dynamic>('');
        expect(
          data,
          isNull,
        );
      });
    });

    group('put', () {
      group('throws', () {
        void setUpHttpError(int errorCode) {
          when(
            () => httpClient.put<dynamic>(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException.badResponse(
              statusCode: errorCode,
              requestOptions: RequestOptions(),
              response: Response(
                statusCode: errorCode,
                requestOptions: RequestOptions(),
              ),
            ),
          );
        }

        test(
            'expected BadRequestException '
            'on 400 response', () async {
          setUpHttpError(400);
          expect(
            apiClient.put<dynamic>(''),
            throwsA(isA<BadRequestException>()),
          );
        });

        test(
            'expected UnauthorizedException '
            'on 401 response', () async {
          setUpHttpError(401);
          expect(
            apiClient.put<dynamic>(''),
            throwsA(isA<UnauthorizedException>()),
          );
        });

        test(
            'expected ForbiddenException '
            'on 403 response', () async {
          setUpHttpError(403);
          expect(
            apiClient.put<dynamic>(''),
            throwsA(isA<ForbiddenException>()),
          );
        });

        test(
            'expected NetworkException '
            'on other response', () async {
          setUpHttpError(-1);
          expect(
            apiClient.put<dynamic>(''),
            throwsA(isA<NetworkException>()),
          );
        });
      });

      test(
          'returns data if response is successful '
          'with request headers', () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn(fakeResponseData);

        when(
          () => httpClient.put<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.put<dynamic>(
          '',
          headers: {'key': 'value'},
        );
        expect(
          data,
          equals(fakeResponseData),
        );
      });

      test('returns data if response is successful (200 with non-empty data)',
          () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn(fakeResponseData);

        when(
          () => httpClient.put<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.put<dynamic>('');
        expect(
          data,
          equals(fakeResponseData),
        );
      });

      test('returns data if response is successful (204 with empty data)',
          () async {
        when(() => response.statusCode).thenReturn(204);
        when(() => response.data).thenReturn(null);

        when(
          () => httpClient.put<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.put<dynamic>('');
        expect(
          data,
          isNull,
        );
      });
    });

    group('delete', () {
      group('throws', () {
        void setUpHttpError(int errorCode) {
          when(
            () => httpClient.delete<dynamic>(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException.badResponse(
              statusCode: errorCode,
              requestOptions: RequestOptions(),
              response: Response(
                statusCode: errorCode,
                requestOptions: RequestOptions(),
              ),
            ),
          );
        }

        test(
            'expected BadRequestException '
            'on 400 response', () async {
          setUpHttpError(400);
          expect(
            apiClient.delete<dynamic>(''),
            throwsA(isA<BadRequestException>()),
          );
        });

        test(
            'expected UnauthorizedException '
            'on 401 response', () async {
          setUpHttpError(401);
          expect(
            apiClient.delete<dynamic>(''),
            throwsA(isA<UnauthorizedException>()),
          );
        });

        test(
            'expected ForbiddenException '
            'on 403 response', () async {
          setUpHttpError(403);
          expect(
            apiClient.delete<dynamic>(''),
            throwsA(isA<ForbiddenException>()),
          );
        });

        test(
            'expected NetworkException '
            'on other response', () async {
          setUpHttpError(-1);
          expect(
            apiClient.delete<dynamic>(''),
            throwsA(isA<NetworkException>()),
          );
        });
      });

      test(
          'returns data if response is successful '
          'with request headers', () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn(fakeResponseData);

        when(
          () => httpClient.delete<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.delete<dynamic>(
          '',
          headers: {'key': 'value'},
        );
        expect(
          data,
          equals(fakeResponseData),
        );
      });

      test('returns data if response is successful (200 with non-empty data)',
          () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn(fakeResponseData);

        when(
          () => httpClient.delete<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.delete<dynamic>('');
        expect(
          data,
          equals(fakeResponseData),
        );
      });

      test('returns data if response is successful (204 with empty data)',
          () async {
        when(() => response.statusCode).thenReturn(204);
        when(() => response.data).thenReturn(null);

        when(
          () => httpClient.delete<dynamic>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        final data = await apiClient.delete<dynamic>('');
        expect(
          data,
          isNull,
        );
      });
    });
  });
}
