import 'package:cookify/feature/auth/restore/domain/payloads/resend_restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/payloads/verify_restore_payload.dart';

abstract interface class RestoreRepository {
  Future<bool> restore(RestorePayload restorePayload);

  Future<bool> verifyCode(VerifyRestorePayload verifySignUpPayload);

  Future<void> resendCode(ResendRestorePayload resendSignUpPayload);
}
