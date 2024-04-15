import 'package:restaurantour/data/datasources/local_data_source.dart';
import 'package:restaurantour/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final LocalDataSource localDataSource;

  FavoriteRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addFavorite(String id) async {
    try {
      await localDataSource.addFavorite(id);
    } on Exception {
      throw Exception('Failed to add favorite');
    }
  }

  @override
  Future<void> removeFavorite(String id) async {
    try {
      await localDataSource.removeFavorite(id);
    } on Exception {
      throw Exception('Failed to remove favorite');
    }
  }

  @override
  Future<List<String>> getFavorites() async {
    try {
      return await localDataSource.getFavorites();
    } on Exception {
      throw Exception('Failed to get favorites');
    }
  }
}
