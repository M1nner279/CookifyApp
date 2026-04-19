import 'package:cookify/features/auth/restore/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/auth/restore/data/requests/restore_request.dart';
import 'package:cookify/features/auth/restore/domain/exceptions/restore_exception.dart';
import 'package:cookify/features/auth/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/features/auth/restore/domain/repositories/restore_repository.dart';
import 'package:dio/dio.dart';

class RestoreRepositoryImpl implements RestoreRepository {
  RestoreRepositoryImpl({required RestoreRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final RestoreRemoteDataSource _remoteDataSource;

  @override
  Future<void> restore(RestorePayload payload) async {
    try {
      await _remoteDataSource.restore(
        RestoreRequest(login: payload.login),
      );
    } on DioException {
      throw NonExistentLoginOrEmailException();
    }
  }
}
