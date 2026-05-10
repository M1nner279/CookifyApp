import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/credentials_validation/domain/enums/email_validation_status.dart';
import 'package:flutter/material.dart';

extension LocalizedEmailValidationStatus on EmailValidationStatus {
  String localize(BuildContext context) => switch (this) {
    EmailValidationStatus.empty => MyLocale.of(context).validationFieldRequired,
    EmailValidationStatus.invalid => MyLocale.of(
      context,
    ).validationEmailInvalid,
    EmailValidationStatus.valid => '',
  };
}
