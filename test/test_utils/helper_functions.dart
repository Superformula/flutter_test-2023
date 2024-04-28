import 'package:flutter/material.dart';
import 'package:restaurantour/localization/localization.dart';

/// Returns an [AppLocalizations] for the english locale.
Future<AppLocalizations> loadEnglishLocalizations() async =>
    AppLocalizations.delegate.load(const Locale('en'));
