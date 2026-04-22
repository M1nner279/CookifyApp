import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_email_payload.freezed.dart';

@freezed
abstract class ValidateEmailPayload with _$ValidateEmailPayload {
  const factory ValidateEmailPayload({required String email}) =
      _ValidateEmailPayload;
}
