import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/profile/domain/entities/user_entity.dart';
import 'package:cookify/features/profile/domain/repositories/profile_repository.dart';

final class GetUserUseCase {
  GetUserUseCase(this._repository);

  final ProfileRepository _repository;

  Future<MyEither<UserEntity>> call() {
    return _repository.getUser();
  }
}
