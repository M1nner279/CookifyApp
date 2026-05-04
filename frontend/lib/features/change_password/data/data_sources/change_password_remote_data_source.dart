
import 'package:cookify/features/change_password/data/requests/change_password_request.dart';

abstract interface class ChangePasswordRemoteDataSource {
  Future<void> changePassword(ChangePasswordRequest request); 
}