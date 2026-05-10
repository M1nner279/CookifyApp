import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/credentials_validation/domain/enums/login_validation_status.dart';
import 'package:flutter/material.dart';

extension LocalizedLoginValidationStatus on LoginValidationStatus {
  String localize(BuildContext context) => switch (this) {
    LoginValidationStatus.empty => MyLocale.of(context).validationFieldRequired,
    LoginValidationStatus.tooShort => MyLocale.of(
      context,
    ).validationLoginTooShort,
    LoginValidationStatus.tooLong => MyLocale.of(
      context,
    ).validationLoginTooLong,
    LoginValidationStatus.valid => '',
  };
}
