import 'package:cookify/core/presentation/localize/localize.dart';

abstract interface class SignUpDependency {
  Localize? validateLogin(String login);

  Localize? validateEmail(String email);

  Localize? validatePassword(String password);

  Localize? validateConfirmPassword(String password, String confirmPassword);
}