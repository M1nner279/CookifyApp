import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/profile/domain/entity/locale_entity.dart';
import 'package:cookify/feature/profile/domain/entity/user_entity.dart';
import 'package:cookify/feature/profile/domain/entity/user_info_entity.dart';
import 'package:cookify/feature/profile/domain/entity/user_recipe_statistic_entity.dart';
import 'package:cookify/feature/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Either<Failure, UserInfoEntity>> getUserInfo() async {
    return Right(
      UserInfoEntity(
        user: UserEntity(
          id: '0',
          avatarUrl: '',
          login: 'pavello06',
          email: 'pavelgaluha@gmail.com',
          createdAt: DateTime.now(),
        ),
        userRecipeStatistic: UserRecipeStatisticEntity(
          favoriteRecipeCount: 10,
          createdRecipeCount: 5,
          publishedRecipeCount: 2,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, LocaleEntity>> getLocale() async {
    return Right(LocaleEntity(languageCode: Locale('en')));
  }
}
