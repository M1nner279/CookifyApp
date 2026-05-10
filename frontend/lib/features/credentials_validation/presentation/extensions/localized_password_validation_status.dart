import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/credentials_validation/domain/enums/password_validation_status.dart';
import 'package:flutter/material.dart';

extension LocalizedPasswordValidationStatus on PasswordValidationStatus {
  String localize(BuildContext context) => switch (this) {
    PasswordValidationStatus.empty => MyLocale.of(
      context,
    ).validationFieldRequired,
    PasswordValidationStatus.tooShort => MyLocale.of(
      context,
    ).validationPasswordTooShort,
    PasswordValidationStatus.tooLong => MyLocale.of(
      context,
    ).validationPasswordTooLong,
    PasswordValidationStatus.invalid => MyLocale.of(
      context,
    ).validationPasswordInvalid,
    PasswordValidationStatus.valid => '',
  };
}
