import 'package:freezed_annotation/freezed_annotation.dart';

part 'restore_payload.freezed.dart';

@freezed
abstract class RestorePayload with _$RestorePayload {
  const factory RestorePayload({
    required String loginOrEmail,
  }) = _RestorePayload;
}
