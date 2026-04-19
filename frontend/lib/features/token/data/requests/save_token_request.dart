import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_token_request.freezed.dart';
part 'save_token_request.g.dart';

@freezed
abstract class SaveTokenRequest with _$SaveTokenRequest {
  const factory SaveTokenRequest({required TokenModel token}) =
      _SaveTokenRequest;

  factory SaveTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveTokenRequestFromJson(json);
}
