import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_password_payload.freezed.dart';

@freezed
abstract class ValidatePasswordPayload with _$ValidatePasswordPayload {
  const factory ValidatePasswordPayload({required String password}) =
      _ValidatePasswordPayload;
}
