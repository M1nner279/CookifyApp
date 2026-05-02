import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_avatar_payload.freezed.dart';

@freezed
abstract class UpdateAvatarPayload with _$UpdateAvatarPayload {
  const factory UpdateAvatarPayload({required File avatarFile}) =
      _UpdateAvatarPayload;
}
