import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_code_request.freezed.dart';
part 'confirm_code_request.g.dart';

@freezed
abstract class ConfirmCodeRequest with _$ConfirmCodeRequest {
  const factory ConfirmCodeRequest({
    required String login,
  }) = _ConfirmCodeRequest;

  factory ConfirmCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmCodeRequestFromJson(json);
}
