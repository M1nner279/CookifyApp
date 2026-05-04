import 'package:cookify/core/domain/failures/failures.dart';

final class LoginAlreadyExistsFailure extends Failure {
  const LoginAlreadyExistsFailure();
}

final class EmailAlreadyExistsFailure extends Failure {
  const EmailAlreadyExistsFailure();
}
