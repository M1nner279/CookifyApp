import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/credentials_validation/domain/enums/confirm_password_validation_status.dart';
import 'package:flutter/material.dart';

extension LocalizedConfirmPasswordValidationStatus
    on ConfirmPasswordValidationStatus {
  String localize(BuildContext context) => switch (this) {
    ConfirmPasswordValidationStatus.notMatch => MyLocale.of(
      context,
    ).validationConfirmPasswordNotMatch,
    ConfirmPasswordValidationStatus.valid => '',
  };
}
