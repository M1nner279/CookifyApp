import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/sign_in/data/data_sources/sign_in_remote_data_source.dart';
import 'package:cookify/features/sign_in/data/mappers/sign_in_failure_mapper.dart';
import 'package:cookify/features/sign_in/data/mappers/sign_in_mapper.dart';
import 'package:cookify/features/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:cookify/features/token/data/mappers/token_mapper.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:fpdart/fpdart.dart';

final class SignInRepositoryImpl implements SignInRepository {
  SignInRepositoryImpl({required SignInRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final SignInRemoteDataSource _remoteDataSource;

  @override
  Future<MyEither<Token>> signIn(SignInPayload payload) async {
    try {
      final request = SignInMapper.toRequest(payload);
      final tokenModel = await _remoteDataSource.signIn(request);

      final tokenEntity = TokenMapper.toEntity(tokenModel);

      return Right(tokenEntity);
    } on Exception catch (e) {
      return Left(SignInFailureMapper.toFailure(e));
    }
  }
}
