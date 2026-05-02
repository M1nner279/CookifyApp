import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_event.freezed.dart';

@freezed
sealed class TokenEvent with _$TokenEvent {
  const factory TokenEvent.init() = InitToken;
}
