import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restore_state.freezed.dart';

@freezed
sealed class RestoreState with _$RestoreState {
  const factory RestoreState.initial() = RestoreInitial;

  const factory RestoreState.loading() = RestoreLoading;

  const factory RestoreState.success() = RestoreSuccess;

  const factory RestoreState.error() = RestoreError;
}
