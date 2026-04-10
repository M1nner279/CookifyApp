import 'dart:convert';

import 'package:cookify/feature/auth/sign_in/domain/payloads/safe_sign_in_payload.dart';
import 'package:cookify/feature/auth/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/feature/auth/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:crypto/crypto.dart';

class SignInUseCase {
  SignInUseCase(this._repository);

  final SignInRepository _repository;

  Future<bool> call(SignInPayload signInPayload) {
    final passwordHash = sha256
        .convert(utf8.encode(signInPayload.password))
        .toString();
    final safeSignInPayload = SafeSignInPayload(
      login: signInPayload.login,
      passwordHash: passwordHash,
    );
    return _repository.signIn(safeSignInPayload);
  }
}
