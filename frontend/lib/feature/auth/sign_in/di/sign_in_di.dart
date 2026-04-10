import 'package:cookify/feature/auth/sign_in/data/repositories_impl/sign_in_repository_impl.dart';
import 'package:cookify/feature/auth/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:cookify/feature/auth/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:cookify/feature/auth/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class SignInDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerSingleton<SignInRepository>(SignInRepositoryImpl())
      ..registerSingleton(SignInUseCase(getIt()))
      ..registerSingleton(SignInCubit(signInUseCase: getIt()));
  }
}
