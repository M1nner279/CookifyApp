import 'package:cookify/feature/profile/data/repository_impl/profile_repository_impl.dart';
import 'package:cookify/feature/profile/domain/repository/profile_repository.dart';
import 'package:cookify/feature/profile/domain/use_case/get_locale.dart';
import 'package:cookify/feature/profile/domain/use_case/get_user_info.dart';
import 'package:cookify/feature/profile/presentation/bloc/profile_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class ProfileDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerSingleton<ProfileRepository>(ProfileRepositoryImpl())
      ..registerSingleton(GetUserInfo(getIt()))
      ..registerSingleton(GetLocale(getIt()))
      ..registerSingleton(
        ProfileCubit(getUserInfo: getIt(), getLocale: getIt()),
      );
  }
}
