import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'restaurant_list_localizations_en.dart';

/// Callers can lookup localized strings with an instance of RestaurantListLocalizations
/// returned by `RestaurantListLocalizations.of(context)`.
///
/// Applications need to include `RestaurantListLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/restaurant_list_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: RestaurantListLocalizations.localizationsDelegates,
///   supportedLocales: RestaurantListLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the RestaurantListLocalizations.supportedLocales
/// property.
abstract class RestaurantListLocalizations {
  RestaurantListLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static RestaurantListLocalizations of(BuildContext context) {
    return Localizations.of<RestaurantListLocalizations>(context, RestaurantListLocalizations)!;
  }

  static const LocalizationsDelegate<RestaurantListLocalizations> delegate = _RestaurantListLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'RestauranTour'**
  String get appBarTitle;

  /// No description provided for @allRestaurantsTabTitle.
  ///
  /// In en, this message translates to:
  /// **'All restaurants'**
  String get allRestaurantsTabTitle;

  /// No description provided for @favoritesTabTitle.
  ///
  /// In en, this message translates to:
  /// **'MyFavorites'**
  String get favoritesTabTitle;

  /// No description provided for @errorToFetchAllRestaurantsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch restaurants'**
  String get errorToFetchAllRestaurantsErrorMessage;

  /// No description provided for @errorToFetchFavoritesErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch favorite restaurants'**
  String get errorToFetchFavoritesErrorMessage;

  /// No description provided for @emptyFavoritesMessage.
  ///
  /// In en, this message translates to:
  /// **'No chef has achieved your heart yet'**
  String get emptyFavoritesMessage;
}

class _RestaurantListLocalizationsDelegate extends LocalizationsDelegate<RestaurantListLocalizations> {
  const _RestaurantListLocalizationsDelegate();

  @override
  Future<RestaurantListLocalizations> load(Locale locale) {
    return SynchronousFuture<RestaurantListLocalizations>(lookupRestaurantListLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_RestaurantListLocalizationsDelegate old) => false;
}

RestaurantListLocalizations lookupRestaurantListLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return RestaurantListLocalizationsEn();
  }

  throw FlutterError(
    'RestaurantListLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
