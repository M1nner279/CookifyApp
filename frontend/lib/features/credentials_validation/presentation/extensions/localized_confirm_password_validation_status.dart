import 'package:cookify/features/credentials_validation/domain/enums/confirm_password_validation_status.dart';
import 'package:flutter/material.dart';

extension LocalizedConfirmPasswordValidationStatus on ConfirmPasswordValidationStatus {
  String localize(BuildContext context) => switch (this) {
    ConfirmPasswordValidationStatus.notMatch => 'Пароли не совпадают',
    ConfirmPasswordValidationStatus.valid => '',
  };
}