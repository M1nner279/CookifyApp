import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:flutter/material.dart';

abstract interface class ProfileDependency {
  Future<MyEither<Locale>> geLocale();

  Future<MyEither<Locale>> setLocale(Locale locale);

  Future<MyEither<void>> deleteToken();
}
