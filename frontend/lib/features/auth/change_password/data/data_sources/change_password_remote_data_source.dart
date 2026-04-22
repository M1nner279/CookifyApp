import 'package:cookify/features/auth/change_password/data/requests/change_password_request.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<void> changePassword(ChangePasswordRequest request);
}
