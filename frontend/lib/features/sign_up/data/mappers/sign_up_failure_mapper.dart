import 'package:cookify/core/data/mappers/failure_mapper.dart';
import 'package:cookify/core/domain/failures/failures.dart';
import 'package:cookify/features/sign_up/data/exceptions/sign_in_exceptions.dart';
import 'package:cookify/features/sign_up/domain/failures/sign_up_failures.dart';

abstract class SignUpFailureMapper {
  static Failure toFailure(Exception exception) {
    switch (exception) {
      case LoginAlreadyExistsException():
        return const LoginAlreadyExistsFailure();
      case EmailAlreadyExistsException():
        return const EmailAlreadyExistsFailure();
      default:
        return FailureMapper.toFailure(exception);
    }
  }
}
