// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('UserRepository', () {
    late UserRepository userRepository;
    setUp(() {
      userRepository = UserRepository();
    });
    group('addFavoriteRestaurant', () {
      test('dont add duplicated restaurants ', () {
        userRepository.addFavoriteRestaurant(Restaurant(id: '1'));
        userRepository.addFavoriteRestaurant(Restaurant(id: '1'));
        expect(userRepository.favoriteRestaurants, [Restaurant(id: '1')]);
      });
    });
    group('removeFavoriteRestaurant', () {
      test('removes correctly a restaurant', () {
        userRepository.addFavoriteRestaurant(Restaurant(id: '1'));
        userRepository.addFavoriteRestaurant(Restaurant(id: '2'));
        userRepository.removeFavoriteRestaurant('1');
        expect(userRepository.favoriteRestaurants, [Restaurant(id: '2')]);
      });
    });
  });
}
