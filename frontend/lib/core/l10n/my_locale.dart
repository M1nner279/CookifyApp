import 'package:cookify/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class MyLocale {
  static const initial = ru;

  static const ru = Locale('ru');
  static const en = Locale('en');

  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const supportedLocales = [ru, en];

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}