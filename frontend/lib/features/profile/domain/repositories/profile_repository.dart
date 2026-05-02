import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/profile/domain/entities/user_entity.dart';
import 'package:cookify/features/profile/domain/payloads/update_avatar_payload.dart';

abstract interface class ProfileRepository {
  Future<MyEither<UserEntity>> getUser();

  Future<MyEither<String>> updateAvatar(UpdateAvatarPayload payload);
}
