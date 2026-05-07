import 'package:cookify/di/di.dart';
import 'package:cookify/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:cookify/features/profile/data/data_sources/profile_remote_data_source_impl.dart';
import 'package:cookify/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:cookify/features/profile/domain/repositories/profile_repository.dart';
import 'package:cookify/features/profile/domain/use_cases/get_user_use_case.dart';
import 'package:cookify/features/profile/domain/use_cases/update_avatar_use_case.dart';

abstract class ProfileDi {
  static ProfileRemoteDataSource get _profileRemoteDataSource =>
      ProfileRemoteDataSourceImpl(dio: Di.dio);

  static ProfileRepository get _profileRepository =>
      ProfileRepositoryImpl(remoteDataSource: _profileRemoteDataSource);

  static GetUserUseCase get getUserUseCase =>
      GetUserUseCase(_profileRepository);

  static UpdateAvatarUseCase get updateAvatarUseCase =>
      UpdateAvatarUseCase(_profileRepository);
}
