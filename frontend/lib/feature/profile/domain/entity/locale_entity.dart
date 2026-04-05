import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_entity.freezed.dart';

@freezed
abstract class LocaleEntity with _$LocaleEntity {
  const factory LocaleEntity({required Locale languageCode}) = _LocaleEntity;
}
