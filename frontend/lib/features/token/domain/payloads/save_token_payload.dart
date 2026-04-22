import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_token_payload.freezed.dart';

@freezed
abstract class SaveTokenPayload with _$SaveTokenPayload {
  const factory SaveTokenPayload({required Token token}) = _SaveTokenPayload;
}
