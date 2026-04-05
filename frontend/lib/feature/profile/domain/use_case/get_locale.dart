import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/profile/domain/entity/locale_entity.dart';
import 'package:cookify/feature/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetLocale {
  GetLocale(ProfileRepository repository) : _repository = repository;

  final ProfileRepository _repository;

  Future<Either<Failure, LocaleEntity>> call() {
    return _repository.getLocale();
  }
}
