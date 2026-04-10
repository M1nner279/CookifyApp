import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_restore_payload.freezed.dart';

@freezed
abstract class ResendRestorePayload with _$ResendRestorePayload {
  const factory ResendRestorePayload({
    required String email,
  }) = _ResendRestorePayload;
}
