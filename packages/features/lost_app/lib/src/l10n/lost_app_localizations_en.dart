import 'lost_app_localizations.dart';

/// The translations for English (`en`).
class LostAppLocalizationsEn extends LostAppLocalizations {
  LostAppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appLostMessage => 'Oops! Looks like we got lost.';

  @override
  String get startOverButton => 'Start over';
}
