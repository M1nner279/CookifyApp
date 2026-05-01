import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_locale_payload.freezed.dart';

@freezed
abstract class SetLocalePayload with _$SetLocalePayload {
  const factory SetLocalePayload({required Locale locale}) = _SetLocalePayload;
}
