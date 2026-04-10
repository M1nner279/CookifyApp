import 'dart:convert';

import 'package:cookify/feature/auth/sign_up/domain/payloads/safe_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/payloads/sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:crypto/crypto.dart';

class SignUpUseCase {
  SignUpUseCase(this._repository);

  final SignUpRepository _repository;

  Future<bool> call(SignUpPayload signUpPayload) {
    final passwordHash = sha256
        .convert(utf8.encode(signUpPayload.password))
        .toString();
    final safeSignUpPayload = SafeSignUpPayload(
      login: signUpPayload.login,
      email: signUpPayload.email,
      passwordHash: passwordHash,
    );
    return _repository.signUp(safeSignUpPayload);
  }
}
