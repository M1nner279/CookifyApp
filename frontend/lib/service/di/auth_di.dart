import 'package:cookify/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:cookify/feature/auth/domain/repository/auth_repository.dart';
import 'package:cookify/feature/auth/domain/usecase/authorize.dart';
import 'package:cookify/feature/auth/domain/usecase/login.dart';
import 'package:cookify/feature/auth/presentation/bloc/login_cubit.dart';
import 'package:get_it/get_it.dart';

class AuthDI {
  static GetIt getIt = GetIt.instance;

  static Future<void> init() async {
    // Utils

    // Home
    // Data sources

    // Repositories
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

    // Use cases
    getIt.registerLazySingleton(() => Authorize(repository: getIt()));
    getIt.registerLazySingleton(() => Login(repository: getIt()));

    // BLoCs
    getIt.registerLazySingleton<LoginCubit>(
      () => LoginCubit(authorize: getIt(), login: getIt()),
    );
  }
}
