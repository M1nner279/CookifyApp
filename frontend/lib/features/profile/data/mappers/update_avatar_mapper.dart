import 'package:cookify/features/profile/data/requests/update_avatar_request.dart';
import 'package:cookify/features/profile/domain/payloads/update_avatar_payload.dart';

abstract class UpdateAvatarMapper {
  static UpdateAvatarRequest toRequest(UpdateAvatarPayload payload) {
    return UpdateAvatarRequest(avatarFile: payload.avatarFile);
  }
}
