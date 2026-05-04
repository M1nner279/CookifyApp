import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/change_password/domain/payloads/change_password_payload.dart';

abstract interface class ChangePasswordRepository {
  Future<MyEither<void>> changePassword(ChangePasswordPayload payload);
}