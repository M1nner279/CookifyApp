import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:cookify/features/sign_up/data/mappers/sign_up_failure_mapper.dart';
import 'package:cookify/features/sign_up/data/mappers/sign_up_mapper.dart';
import 'package:cookify/features/sign_up/domain/payloads/sign_up_payload.dart';
import 'package:cookify/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  SignUpRepositoryImpl({required SignUpRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final SignUpRemoteDataSource _remoteDataSource;

  @override
  Future<MyEither<void>> signUp(SignUpPayload payload) async {
    try {
      final request = SignUpMapper.toRequest(payload);
      final result = await _remoteDataSource.signUp(request);

      return Right(result);
    } on Exception catch (e) {
      return Left(SignUpFailureMapper.toFailure(e));
    }
  }
}
