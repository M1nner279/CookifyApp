import 'package:cookify/feature/auth/restore/domain/payloads/resend_restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/payloads/verify_restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/repositories/restore_repository.dart';

class RestoreRepositoryImpl implements RestoreRepository {
  @override
  Future<bool> restore(RestorePayload restorePayload) {
    return Future.value(true);
  }
  
  @override
  Future<bool> verifyCode(VerifyRestorePayload verifySignUpPayload) {
    return Future.value(true);
  }

  @override
  Future<void> resendCode(ResendRestorePayload resendSignUpPayload) {
    return Future.value();
  }
}
