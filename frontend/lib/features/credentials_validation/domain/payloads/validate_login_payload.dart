import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_login_payload.freezed.dart';

@freezed
abstract class ValidateLoginPayload with _$ValidateLoginPayload {
  const factory ValidateLoginPayload({required String login}) =
      _ValidateLoginPayload;
}
