import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_payload.freezed.dart';

@freezed
abstract class RefreshTokenPayload with _$RefreshTokenPayload {
  const factory RefreshTokenPayload({required String refreshToken}) =
      _RefreshTokenPayload;
}
