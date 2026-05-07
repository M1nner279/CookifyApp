import 'package:cookify/core/domain/failures/failures.dart';
import 'package:cookify/features/profile/domain/entities/user_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial({required Locale locale}) = ProfileInitial;

  const factory ProfileState.loading({required Locale locale}) = ProfileLoading;

  const factory ProfileState.loaded({
    required UserEntity user,
    required Locale locale,
  }) = ProfileLoaded;

  const factory ProfileState.error({
    required Failure failure,
    required Locale locale,
  }) = ProfileError;
}
