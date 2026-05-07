import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/locale/domain/payloads/set_locale_payload.dart';
import 'package:flutter/material.dart';

abstract interface class LocaleRepository {
  Future<MyEither<Locale?>> getLocale();

  Future<MyEither<Locale>> setLocale(SetLocalePayload payload);

  Future<MyEither<Stream<Locale>>> listenLocale();

  Future<MyEither<void>> addLocaleToStream(Locale locale);
}
