import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_code_payload.freezed.dart';

@freezed
abstract class ConfirmCodePayload with _$ConfirmCodePayload {
  const factory ConfirmCodePayload({
    required String login,
    required String code,
  }) = _ConfirmCodePayload;
}
