import 'package:freezed_annotation/freezed_annotation.dart';

part 'restore_request.freezed.dart';
part 'restore_request.g.dart';

@freezed
abstract class RestoreRequest with _$RestoreRequest {
  const factory RestoreRequest({
    required String login,
  }) = _RestoreRequest;

  factory RestoreRequest.fromJson(Map<String, dynamic> json) =>
      _$RestoreRequestFromJson(json);
}
