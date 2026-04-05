import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/profile/domain/entity/locale_entity.dart';
import 'package:cookify/feature/profile/domain/entity/user_info_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;

  const factory ProfileState.loading() = ProfileLoading;

  const factory ProfileState.loaded({
    required UserInfoEntity userInfo,
    required LocaleEntity locale,
    @Default(false) bool isLoading,
    Failure? failure,
  }) = ProfileLoaded;

  const factory ProfileState.error({required Failure failure}) = ProfileError;
}
