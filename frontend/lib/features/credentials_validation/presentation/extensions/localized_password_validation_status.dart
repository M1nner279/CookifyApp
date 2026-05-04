import 'package:cookify/features/credentials_validation/domain/enums/password_validation_status.dart';
import 'package:flutter/material.dart';

extension LocalizedPasswordValidationStatus on PasswordValidationStatus {
  String localize(BuildContext context) => switch (this) {
    PasswordValidationStatus.empty => 'Поле не может быть пустым',
    PasswordValidationStatus.tooShort => 'Пароль слишком короткий',
    PasswordValidationStatus.tooLong => 'Пароль слишком длинный',
    PasswordValidationStatus.invalid => 'Пароль должен содержать строчные и заглавные буквы, цифры и спец символы',
    PasswordValidationStatus.valid => '',
  };
}
