import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sport_app/lang/multi_localizations.dart';

class MultiLocalizationsDelegate
    extends LocalizationsDelegate<MultiLocalizations> {
  const MultiLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<MultiLocalizations> load(Locale locale) => MultiLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<MultiLocalizations> old) => false;
}
