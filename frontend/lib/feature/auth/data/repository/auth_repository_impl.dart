import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, bool>> authorize() async {
    return Right(false);
  }
  
  @override
  Future<Either<Failure, void>> login(String name, String password) async {
    return Right(null);
  }
  
  @override
  Future<Either<Failure, void>> recoverPassword(String email) {
    // TODO: implement recoverPassword
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> register(String name, String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> sendEmailVerification(String code) {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  
}