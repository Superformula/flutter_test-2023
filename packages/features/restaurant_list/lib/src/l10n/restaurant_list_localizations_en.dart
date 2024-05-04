import 'restaurant_list_localizations.dart';

/// The translations for English (`en`).
class RestaurantListLocalizationsEn extends RestaurantListLocalizations {
  RestaurantListLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'RestauranTour';

  @override
  String get allRestaurantsTabTitle => 'All restaurants';

  @override
  String get favoritesTabTitle => 'MyFavorites';

  @override
  String get errorToFetchAllRestaurantsErrorMessage => 'Failed to fetch restaurants';

  @override
  String get errorToFetchFavoritesErrorMessage => 'Failed to fetch favorite restaurants';

  @override
  String get emptyFavoritesMessage => 'No chef has achieved your heart yet';
}
