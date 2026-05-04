import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/restore/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/restore/data/mappers/restore_failure_mapper.dart';
import 'package:cookify/features/restore/data/mappers/restore_mapper.dart';
import 'package:cookify/features/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/features/restore/domain/repositories/restore_repository.dart';
import 'package:fpdart/fpdart.dart';

class RestoreRepositoryImpl implements RestoreRepository {
  RestoreRepositoryImpl({required RestoreRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final RestoreRemoteDataSource _remoteDataSource;

  @override
  Future<MyEither<void>> restore(RestorePayload payload) async {
    try {
      final request = RestoreMapper.toRequest(payload);
      final result = _remoteDataSource.restore(request);

      return Right(result);
    } on Exception catch (e) {
      return Left(RestoreFailureMapper.toFailure(e));
    }
  }
}
