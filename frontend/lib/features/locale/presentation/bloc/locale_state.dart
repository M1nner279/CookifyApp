import 'package:cookify/core/l10n/my_locale.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_state.freezed.dart';

@freezed
sealed class LocaleState with _$LocaleState {
  const factory LocaleState({@Default(MyLocale.initial) Locale locale}) =
      _LocaleState;
}
