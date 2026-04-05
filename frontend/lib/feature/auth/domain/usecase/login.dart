import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Login {
  Login({required this.repository});

  final AuthRepository repository;

  Future<Either<Failure, void>> call(String name, String password) {
    return repository.login(name, password);
  }
}
