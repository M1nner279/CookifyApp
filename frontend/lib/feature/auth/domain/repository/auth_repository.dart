import 'package:cookify/config/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> authorize();

  Future<Either<Failure, void>> login(String name, String password);

  Future<Either<Failure, void>> register(String name, String email, String password);

  Future<Either<Failure, void>> recoverPassword(String email);

  Future<Either<Failure, void>> sendEmailVerification(String code);
}
