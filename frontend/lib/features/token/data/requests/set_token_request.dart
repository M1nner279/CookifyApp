import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_token_request.freezed.dart';
part 'set_token_request.g.dart';

@freezed
abstract class SetTokenRequest with _$SetTokenRequest {
  const factory SetTokenRequest({required TokenModel token}) = _SetTokenRequest;

  factory SetTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$SetTokenRequestFromJson(json);
}
