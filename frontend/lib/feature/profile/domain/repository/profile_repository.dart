import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/profile/domain/entity/locale_entity.dart';
import 'package:cookify/feature/profile/domain/entity/user_info_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, UserInfoEntity>> getUserInfo();

  Future<Either<Failure, LocaleEntity>> getLocale();
}
