import 'restaurant_detail_localizations.dart';

/// The translations for English (`en`).
class RestaurantDetailLocalizationsEn extends RestaurantDetailLocalizations {
  RestaurantDetailLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errorToFetchReviewsMessage => 'Failed to fetch reviews';

  @override
  String get reviewsQuantity => '%s Reviews';

  @override
  String get addressSectionTitle => 'Address';

  @override
  String get ratingSectionTitle => 'Overall rating';

  @override
  String get isOpen => 'Open Now';

  @override
  String get isClosed => 'Closed';
}
