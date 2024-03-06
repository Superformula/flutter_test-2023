import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class MockHiveHelper extends Mock implements HiveHelper {}

class MockYelpRepository extends Mock implements YelpRepository {}
