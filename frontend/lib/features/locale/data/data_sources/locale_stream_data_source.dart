import 'package:flutter/material.dart';

abstract interface class LocaleStreamDataSource {
  Future<Stream<Locale>> listenLocale();

  Future<void> addLocale(Locale locale);
}