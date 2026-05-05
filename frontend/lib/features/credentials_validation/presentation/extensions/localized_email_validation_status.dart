import 'package:cookify/features/credentials_validation/domain/enums/email_validation_status.dart';
import 'package:flutter/material.dart';

extension LocalizedEmailValidationStatus on EmailValidationStatus {
  String localize(BuildContext context) => switch (this) {
    EmailValidationStatus.empty => 'Поле не может быть пустым',
    EmailValidationStatus.invalid => 'Некорректный email',
    EmailValidationStatus.valid => '',
  };
}
