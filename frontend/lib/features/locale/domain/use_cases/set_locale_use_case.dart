import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/locale/domain/payloads/set_locale_payload.dart';
import 'package:cookify/features/locale/domain/repositories/locale_repository.dart';
import 'package:flutter/material.dart';

final class SetLocaleUseCase {
  SetLocaleUseCase(this._repository);

  final LocaleRepository _repository;

  Future<MyEither<Locale>> call(SetLocalePayload payload) {
    return _repository.setLocale(payload);
  }
}
