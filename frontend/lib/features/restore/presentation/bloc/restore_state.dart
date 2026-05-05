import 'package:cookify/core/presentation/localize/localized_error_value.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restore_state.freezed.dart';

@freezed
sealed class RestoreState with _$RestoreState {
  const factory RestoreState({
    @Default(LocalizedErrorValue(value: '')) LocalizedErrorValue login,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
  }) = _RestoreState;
}
