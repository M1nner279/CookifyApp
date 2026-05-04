import 'package:cookify/features/credentials_validation/domain/enums/login_validation_status.dart';
import 'package:flutter/material.dart';

extension LocalizedLoginValidationStatus on LoginValidationStatus {
  String localize(BuildContext context) => switch (this) {
    LoginValidationStatus.empty => 'Поле не может быть пустым',
    LoginValidationStatus.tooShort => 'Логин слишком короткий',
    LoginValidationStatus.tooLong => 'Логин слишком длинный',
    LoginValidationStatus.valid => '',
  };
}
