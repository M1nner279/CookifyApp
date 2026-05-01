import 'package:cookify/core/data/mappers/failure_mapper.dart';
import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:cookify/features/profile/data/mappers/update_avatar_mapper.dart';
import 'package:cookify/features/profile/data/mappers/user_mapper.dart';
import 'package:cookify/features/profile/domain/entities/user_entity.dart';
import 'package:cookify/features/profile/domain/payloads/update_avatar_payload.dart';
import 'package:cookify/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required ProfileRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<MyEither<UserEntity>> getUser() async {
    try {
      final userModel = await _remoteDataSource.getUser();

      final userEntity = UserMapper.toEntity(userModel);

      return Right(userEntity);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<String>> updateAvatar(UpdateAvatarPayload payload) async {
    try {
      final request = UpdateAvatarMapper.toRequest(payload);
      final avatarUrl = await _remoteDataSource.updateAvatar(request);

      return Right(avatarUrl);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }
}
