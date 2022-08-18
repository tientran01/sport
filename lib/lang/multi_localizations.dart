

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MultiLocalizations {
  static Future<MultiLocalizations> load(Locale locale) async {
    final String localeName =
        locale.countryCode == null || locale.countryCode!.isEmpty
            ? locale.languageCode
            : locale.toString();
    final String canonicalLocaleName = Intl.canonicalizedLocale(localeName);
    Intl.defaultLocale = canonicalLocaleName;
    return MultiLocalizations();
  }
  static MultiLocalizations? of(BuildContext context) =>
      Localizations.of<MultiLocalizations>(context, MultiLocalizations);
}