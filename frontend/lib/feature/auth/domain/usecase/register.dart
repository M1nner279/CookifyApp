import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Register {
  Register({required this._repository});

  final AuthRepository _repository;

  Future<Either<Failure, void>> call(String name, String email, String password) {
    return _repository.register(name, email, password);
  }
}
