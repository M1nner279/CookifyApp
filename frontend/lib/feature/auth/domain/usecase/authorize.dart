import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Authorize {
  Authorize({required this.repository});

  final AuthRepository repository;

  Future<Either<Failure, bool>> call() { return repository.authorize(); }
}