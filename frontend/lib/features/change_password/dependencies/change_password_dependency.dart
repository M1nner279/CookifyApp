import 'package:cookify/core/presentation/localize/localize.dart';

abstract interface class ChangePasswordDependency {
  Localize? validatePassword(String password);

  Localize? validateConfirmPassword(
    String password,
    String confirmPassword,
  );
}
