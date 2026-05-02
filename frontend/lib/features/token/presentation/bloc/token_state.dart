import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_state.freezed.dart';

@freezed
sealed class TokenState with _$TokenState {
  const factory TokenState() = _TokenState;
}
