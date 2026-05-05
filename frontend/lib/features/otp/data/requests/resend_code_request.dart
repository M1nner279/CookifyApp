import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_code_request.freezed.dart';
part 'resend_code_request.g.dart';

@freezed
abstract class ResendCodeRequest with _$ResendCodeRequest {
  const factory ResendCodeRequest({
    required String login,
  }) = _ResendCodeRequest;

  factory ResendCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeRequestFromJson(json);
}
