import 'restaurant_list_localizations.dart';

/// The translations for English (`en`).
class RestaurantListLocalizationsEn extends RestaurantListLocalizations {
  RestaurantListLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'RestauranTour';

  @override
  String get allRestaurantsTabTitle => 'All Restaurants';

  @override
  String get favoritesTabTitle => 'My Favorites';

  @override
  String get errorToFetchAllRestaurantsErrorMessage => 'Failed to fetch restaurants';

  @override
  String get errorToFetchFavoritesErrorMessage => 'Failed to fetch favorite restaurants';

  @override
  String get emptyFavoritesMessage => 'No chef has achieved your heart yet';

  @override
  String get isOpen => 'Open Now';

  @override
  String get isClosed => 'Closed';
}
