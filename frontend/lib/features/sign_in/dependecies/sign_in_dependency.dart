import 'package:cookify/core/presentation/localize/localize.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

abstract interface class SignInDependency {
  Localize? validateLogin(String login);

  Localize? validatePassword(String password);

  Future<void> setToken(Token token);
}
