import 'package:cookify/core/data/mappers/failure_mapper.dart';
import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/change_password/data/data_sources/change_password_remote_data_source.dart';
import 'package:cookify/features/change_password/data/mappers/change_password_mapper.dart';
import 'package:cookify/features/change_password/domain/payloads/change_password_payload.dart';
import 'package:cookify/features/change_password/domain/repositories/change_password_repository.dart';
import 'package:fpdart/fpdart.dart';

final class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  ChangePasswordRepositoryImpl({
    required ChangePasswordRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final ChangePasswordRemoteDataSource _remoteDataSource;

  @override
  Future<MyEither<void>> changePassword(ChangePasswordPayload payload) async {
    try {
      final request = ChangePasswordMapper.toRequest(payload);
      final result = await _remoteDataSource.changePassword(request);

      return Right(result);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }
}
