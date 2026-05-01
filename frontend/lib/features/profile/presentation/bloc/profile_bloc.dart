import 'dart:async';

import 'package:cookify/features/profile/dependencies/profile_dependency.dart';
import 'package:cookify/features/profile/domain/payloads/update_avatar_payload.dart';
import 'package:cookify/features/profile/domain/use_cases/get_user_use_case.dart';
import 'package:cookify/features/profile/domain/use_cases/update_avatar_use_case.dart';
import 'package:cookify/features/profile/navigator/profile_navigator.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_event.dart';
import 'package:cookify/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileNavigator profileNavigator,
    required ProfileDependency profileDependency,
    required GetUserUseCase getUserUseCase,
    required UpdateAvatarUseCase updateAvatarUseCase,
  }) : _profileNavigator = profileNavigator,
       _profileDependency = profileDependency,
       _getUserUseCase = getUserUseCase,
       _updateAvatarUseCase = updateAvatarUseCase,
       super(ProfileInitial()) {
    on<InitProfile>(_onInitProfile);
    on<UpdateAvatar>(_onUpdateAvatar);
    on<ChangeLocale>(_onChangeLocale);
    on<PushChangePassword>(_onPushChangePassword);
    on<Logout>(_onLogout);
  }

  ProfileNavigator? _profileNavigator;
  final ProfileDependency _profileDependency;
  final GetUserUseCase _getUserUseCase;
  final UpdateAvatarUseCase _updateAvatarUseCase;

  FutureOr<void> _onInitProfile(
    InitProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final userResult = await _getUserUseCase();
    final localeResult = await _profileDependency.geLocale();
    if (isClosed) return;

    emit(
      userResult.fold(
        (failure) => ProfileError(failure: failure),
        (user) => localeResult.fold(
          (failure) => ProfileError(failure: failure),
          (locale) => ProfileLoaded(user: user, locale: locale),
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateAvatar(
    UpdateAvatar event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;

    final result = await _updateAvatarUseCase(
      UpdateAvatarPayload(avatarFile: event.avatarFile),
    );
    if (isClosed) return;

    final loadedState = state as ProfileLoaded;
    emit(
      result.fold(
        (failure) => ProfileError(failure: failure),
        (avatarUrl) => loadedState.copyWith(
          user: loadedState.user.copyWith(avatarUrl: avatarUrl),
        ),
      ),
    );
  }

  FutureOr<void> _onChangeLocale(
    ChangeLocale event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;

    final result = await _profileDependency.setLocale(event.locale);
    if (isClosed) return;

    final loadedState = state as ProfileLoaded;
    emit(
      result.fold(
        (failure) => ProfileError(failure: failure),
        (locale) => loadedState.copyWith(locale: locale),
      ),
    );
  }

  FutureOr<void> _onPushChangePassword(
    PushChangePassword event,
    Emitter<ProfileState> emit,
  ) {
    _profileNavigator?.pushChangePassword();
  }

  FutureOr<void> _onLogout(Logout event, Emitter<ProfileState> emit) async {
    await _profileDependency.deleteToken();
    _profileNavigator?.goAuth();
  }

  @override
  Future<void> close() {
    _profileNavigator = null;
    return super.close();
  }
}
