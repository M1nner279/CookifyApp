import 'package:cookify/core/presentation/localize/localize.dart';

abstract interface class RestoreDependency {
  Localize? validateLogin(String login);

  Localize? validateEmail(String email);
}