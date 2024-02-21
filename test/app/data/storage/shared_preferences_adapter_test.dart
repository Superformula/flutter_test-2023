import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/data/storage/local_storage.dart';
import 'package:restaurantour/app/data/storage/shared_preferences_adapter_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late LocalStorage dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = SharedPreferencesAdapterImpl();
  });

  test(
    'saveData: should compare SharedPreferences cache data',
    () async {
      //arrange
      Map<String, String> values = <String, String>{
        'savedDataKey': 'Saved Data',
      };
      SharedPreferences.setMockInitialValues(values);
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      //act
      await dataSource.saveData('savedDataKey', 'Saved Data');

      //assert
      final actualStringData = sharedPreferences.getString('savedDataKey');
      const expectedStringData = 'Saved Data';

      expect(actualStringData, expectedStringData);
    },
  );
  test(
    'saveList: should compare SharedPreferences cache data',
    () async {
      //arrange
      Map<String, List<String>> values = <String, List<String>>{
        'savedDataKey': ['Saved Data'],
      };
      SharedPreferences.setMockInitialValues(values);
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      //act
      await dataSource.saveList('savedDataKey', ['Saved Data']);

      //assert
      final actualStringData = sharedPreferences.getStringList('savedDataKey');
      const expectedStringData = ['Saved Data'];

      expect(actualStringData, expectedStringData);
    },
  );

  group('fetchData', () {
    test(
      'should return saved data from SharedPreferences when there is one in the cache.',
      () async {
        //arrange
        Map<String, String> values = <String, String>{
          'savedDataKey': 'Saved Data',
        };
        SharedPreferences.setMockInitialValues(values);

        //act
        final result = await dataSource.fetchData('savedDataKey');

        //assert
        expect(result, 'Saved Data');
      },
    );

    test(
      'should throw a CacheException when there is not a cached value.',
      () async {
        //arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);

        //act
        final call = dataSource.fetchData;

        //assert
        expect(() => call('anyKey'), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('fetchListData: ', () {
    test(
      'should return saved list data from SharedPreferences when there is one in the cache.',
      () async {
        //arrange
        Map<String, List<String>> values = <String, List<String>>{
          'savedDataKey': ['Saved Data'],
        };
        SharedPreferences.setMockInitialValues(values);

        //act
        final result = await dataSource.fetchListData('savedDataKey');

        //assert
        expect(result, ['Saved Data']);
      },
    );

    test(
      'should throw a CacheException when there is not a cached value.',
      () async {
        //arrange
        when(() => mockSharedPreferences.getStringList(any())).thenReturn(null);

        //act
        final call = dataSource.fetchListData;

        //assert
        expect(() => call('anyKey'), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });
}
