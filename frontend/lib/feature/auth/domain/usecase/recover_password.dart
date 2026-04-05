import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RecoverPassword {
  RecoverPassword({required this.repository});

  final AuthRepository repository;

  Future<Either<Failure, void>> call(String email) {
    return repository.recoverPassword(email);
  }
}
