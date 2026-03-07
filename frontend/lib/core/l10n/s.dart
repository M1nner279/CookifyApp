import 'package:cookify/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class S {
  static const ru = Locale('ru');

  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const supportedLocales = [ru];

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}