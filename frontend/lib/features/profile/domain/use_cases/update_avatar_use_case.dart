import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/profile/domain/payloads/update_avatar_payload.dart';
import 'package:cookify/features/profile/domain/repositories/profile_repository.dart';

final class UpdateAvatarUseCase {
  UpdateAvatarUseCase(this._repository);

  final ProfileRepository _repository;

  Future<MyEither<String>> call(UpdateAvatarPayload payload) {
    return _repository.updateAvatar(payload);
  }
}
