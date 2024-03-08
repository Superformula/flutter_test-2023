import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/services/favorite_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test.dart';

void main() {
  SharedPreferences sharedPreferences = SharedPreferencesMock();

  setUp(() {
    GetIt.I.registerFactory<SharedPreferences>(() => sharedPreferences);
  });

  tearDown(() {
    reset(sharedPreferences);
    GetIt.I.reset();
  });

  test('when loadFavorites is called should get the value from service', () async {
    when(() => sharedPreferences.getStringList(any())).thenReturn([]);

    final sut = FavoriteService(sharedPreferences: sharedPreferences);
    final result = await sut.getFavorites();

    expect(result, <String>[]);
  });

  test('when addFavorite is called should save the value on service', () async {
    when(() => sharedPreferences.setStringList(any(), any())).thenAnswer((_) => Future.value(true));

    final sut = FavoriteService(sharedPreferences: sharedPreferences);

    await sut.addFavorite('favoriteId');
    verify(() => sharedPreferences.setStringList(any(), ['favoriteId'])).called(1);
  });

  test('when remove is called should remove the value from service', () async {
    when(() => sharedPreferences.getStringList(any())).thenReturn(['favoriteId']);
    when(() => sharedPreferences.setStringList(any(), any())).thenAnswer((_) => Future.value(true));

    final sut = FavoriteService(sharedPreferences: sharedPreferences);

    await sut.removeFavorite('favoriteId');
    verify(() => sharedPreferences.setStringList(any(), [])).called(1);
  });
}
