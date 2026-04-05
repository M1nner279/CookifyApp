import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/profile/domain/entity/user_info_entity.dart';
import 'package:cookify/feature/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserInfo {
  GetUserInfo(ProfileRepository repository) : _repository = repository;

  final ProfileRepository _repository;

  Future<Either<Failure, UserInfoEntity>> call() {
    return _repository.getUserInfo();
  }
}
