import 'package:cookify/core/data/mappers/failure_mapper.dart';
import 'package:cookify/core/domain/failures/failures.dart';
import 'package:cookify/features/sign_in/data/exceptions/sign_in_exceptions.dart';
import 'package:cookify/features/sign_in/domain/failures/sign_in_failures.dart';

abstract class SignInFailureMapper {
  static Failure toFailure(Exception exception) {
    switch (exception) {
      case IncorrectLoginOrPasswordException():
        return const IncorrectLoginOrPasswordFailure();
      default:
        return FailureMapper.toFailure(exception);
    }
  }
}
