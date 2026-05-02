import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_event.freezed.dart';

@freezed
sealed class LocaleEvent with _$LocaleEvent {
  const factory LocaleEvent.init() = InitLocale;
}