import 'package:cookify/features/profile/data/models/user_model.dart';
import 'package:cookify/features/profile/data/requests/update_avatar_request.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> getUser();

  Future<String> updateAvatar(UpdateAvatarRequest request);
}