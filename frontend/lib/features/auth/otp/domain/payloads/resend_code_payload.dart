import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_code_payload.freezed.dart';

@freezed
abstract class ResendCodePayload with _$ResendCodePayload {
  const factory ResendCodePayload({required String login}) = _ResendCodePayload;
}
