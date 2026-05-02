import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_avatar_request.freezed.dart';

@freezed
abstract class UpdateAvatarRequest with _$UpdateAvatarRequest {
  const factory UpdateAvatarRequest({required File avatarFile}) =
      _UpdateAvatarRequest;
}
