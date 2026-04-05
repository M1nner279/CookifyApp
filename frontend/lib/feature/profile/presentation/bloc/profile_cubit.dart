import 'package:cookify/feature/profile/domain/use_case/get_locale.dart';
import 'package:cookify/feature/profile/domain/use_case/get_user_info.dart';
import 'package:cookify/feature/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required GetUserInfo getUserInfo, required GetLocale getLocale})
    : _getUserInfo = getUserInfo,
      _getLocale = getLocale,
      super(ProfileInitial());

  final GetUserInfo _getUserInfo;
  final GetLocale _getLocale;

  Future<void> init() async {
    emit(ProfileLoading());

    final userInfoOrFailure = await _getUserInfo();
    final localeOrFailure = await _getLocale();

    if (!isClosed) {
      emit(
        userInfoOrFailure.fold(
          (failure) => ProfileError(failure: failure),
          (userInfo) => localeOrFailure.fold(
            (failure) => ProfileError(failure: failure),
            (locale) => ProfileLoaded(userInfo: userInfo, locale: locale),
          ),
        ),
      );
    }
  }
}
