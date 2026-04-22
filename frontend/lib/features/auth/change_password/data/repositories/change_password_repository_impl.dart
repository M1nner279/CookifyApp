import 'package:cookify/features/auth/change_password/data/data_sources/change_password_remote_data_source.dart';
import 'package:cookify/features/auth/change_password/data/requests/change_password_request.dart';
import 'package:cookify/features/auth/change_password/domain/payloads/change_password_payload.dart';
import 'package:cookify/features/auth/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  ChangePasswordRepositoryImpl({
    required ChangePasswordRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final ChangePasswordRemoteDataSource _remoteDataSource;

  @override
  Future<void> changePassword(ChangePasswordPayload payload) async {
    await _remoteDataSource.changePassword(
      ChangePasswordRequest(password: payload.password),
    );
  }
}
