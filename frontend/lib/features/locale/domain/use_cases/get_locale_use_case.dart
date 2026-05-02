import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/locale/domain/repositories/locale_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

final class GetLocaleUseCase {
  GetLocaleUseCase(this._repository);

  final LocaleRepository _repository;

  Future<MyEither<Locale>> call() async {
    return (await _repository.getLocale()).fold(
      (failure) => Left(failure),
      (locale) => Right(locale ?? MyLocale.initial),
    );
  }
}
