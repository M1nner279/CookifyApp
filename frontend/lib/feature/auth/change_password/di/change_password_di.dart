import 'package:cookify/feature/auth/change_password/data/repositories_impl/change_password_repository_impl.dart';
import 'package:cookify/feature/auth/change_password/domain/repositories/change_password_repository.dart';
import 'package:cookify/feature/auth/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:cookify/feature/auth/change_password/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/feature/auth/change_password/domain/use_cases/validate_new_password_use_case.dart';
import 'package:cookify/feature/auth/change_password/presentation/bloc/change_password_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class ChangePasswordDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerSingleton<ChangePasswordRepository>(ChangePasswordRepositoryImpl())
      ..registerSingleton(ValidateNewPasswordUseCase())
      ..registerSingleton(ValidateConfirmPasswordUseCase())
      ..registerSingleton(ChangePasswordUseCase(getIt()))
      ..registerSingleton(
        ChangePasswordCubit(
          validateNewPasswordUseCase: getIt(),
          validateConfirmPasswordUseCase: getIt(),
          changePasswordUseCase: getIt(),
        ),
      );
  }
}