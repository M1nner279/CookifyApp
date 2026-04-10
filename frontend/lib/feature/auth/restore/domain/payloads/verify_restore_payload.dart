import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_restore_payload.freezed.dart';

@freezed
abstract class VerifyRestorePayload with _$VerifyRestorePayload {
  const factory VerifyRestorePayload({
    required String email,
    required String code,
  }) = _VerifyRestorePayload;
}
