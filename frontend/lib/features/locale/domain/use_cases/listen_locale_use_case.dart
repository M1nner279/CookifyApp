import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/locale/domain/repositories/locale_repository.dart';
import 'package:flutter/material.dart';

final class ListenLocaleUseCase {
  ListenLocaleUseCase(this._repository);

  final LocaleRepository _repository;

  Future<MyEither<Stream<Locale>>> call() {
    return _repository.listenLocale();
  }
}
