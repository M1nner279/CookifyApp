import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_token_payload.freezed.dart';

@freezed
abstract class SetTokenPayload with _$SetTokenPayload {
  const factory SetTokenPayload({required Token token}) = _SetTokenPayload;
}
