import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/locale/domain/payloads/set_locale_payload.dart';
import 'package:cookify/features/locale/domain/use_cases/get_locale_use_case.dart';
import 'package:cookify/features/locale/domain/use_cases/set_locale_use_case.dart';
import 'package:cookify/features/profile/dependencies/profile_dependency.dart';
import 'package:cookify/features/token/domain/use_cases/delete_token_use_case.dart';
import 'package:flutter/material.dart';

final class ProfileDependencyImpl implements ProfileDependency {
  ProfileDependencyImpl({
    required GetLocaleUseCase getLocaleUseCase,
    required SetLocaleUseCase setLocaleUseCase,
    required DeleteTokenUseCase deleteTokenUseCase,
  }) : _getLocaleUseCase = getLocaleUseCase,
       _setLocaleUseCase = setLocaleUseCase,
       _deleteTokenUseCase = deleteTokenUseCase;

  final GetLocaleUseCase _getLocaleUseCase;
  final SetLocaleUseCase _setLocaleUseCase;
  final DeleteTokenUseCase _deleteTokenUseCase;

  @override
  Future<MyEither<Locale>> geLocale() {
    return _getLocaleUseCase();
  }

  @override
  Future<MyEither<Locale>> setLocale(Locale locale) {
    return _setLocaleUseCase(SetLocalePayload(locale: locale));
  }

  @override
  Future<MyEither<void>> deleteToken() {
    return _deleteTokenUseCase();
  }
}
