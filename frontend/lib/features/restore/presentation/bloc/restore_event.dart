import 'package:freezed_annotation/freezed_annotation.dart';

part 'restore_event.freezed.dart';

@freezed
sealed class RestoreEvent with _$RestoreEvent {
  const factory RestoreEvent.validateLogin({required String login}) =
      ValidateLogin;

  const factory RestoreEvent.restore() = Restore;
}
