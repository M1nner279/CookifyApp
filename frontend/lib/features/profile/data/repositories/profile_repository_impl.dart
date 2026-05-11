import 'dart:convert';

import 'package:cookify/core/data/mappers/failure_mapper.dart';
import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/di/di.dart';
import 'package:cookify/features/profile/data/local/user_statistic_local_store.dart';
import 'package:cookify/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:cookify/features/profile/data/mappers/update_avatar_mapper.dart';
import 'package:cookify/features/profile/data/mappers/user_mapper.dart';
import 'package:cookify/features/profile/data/models/user_model.dart';
import 'package:cookify/features/profile/domain/entities/user_entity.dart';
import 'package:cookify/features/profile/domain/payloads/update_avatar_payload.dart';
import 'package:cookify/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required ProfileRemoteDataSource remoteDataSource,
    required UserStatisticLocalStore userStatisticLocalStore,
  }) : _remoteDataSource = remoteDataSource,
       _userStatisticLocalStore = userStatisticLocalStore;

  final ProfileRemoteDataSource _remoteDataSource;
  final UserStatisticLocalStore _userStatisticLocalStore;

  @override
  Future<MyEither<UserEntity>> getUser() async {
    try {
      UserModel? userModel;
      try {
        userModel = await _remoteDataSource.getUser();
        Di.getIt<FlutterSecureStorage>().write(
          key: 'profile',
          value: jsonEncode(userModel.toJson()),
        );
      } catch (e) {
        try {
          userModel = UserModel.fromJson(
            jsonDecode(
              await Di.getIt<FlutterSecureStorage>().read(key: 'profile')
                  as String,
            ),
          );
        } catch (_) {
          throw e;
        }
      }
      final userEntity = UserMapper.toEntity(userModel);
      final statisticDelta = await _userStatisticLocalStore.getDelta();
      final actualUserEntity = userEntity.copyWith(
        statistic: userEntity.statistic.copyWith(
          favoriteRecipesCount:
              userEntity.statistic.favoriteRecipesCount +
              statisticDelta.favoriteRecipesCount,
          createdRecipesCount:
              userEntity.statistic.createdRecipesCount +
              statisticDelta.createdRecipesCount,
          publishedRecipesCount:
              userEntity.statistic.publishedRecipesCount +
              statisticDelta.publishedRecipesCount,
        ),
      );

      return Right(actualUserEntity);
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
