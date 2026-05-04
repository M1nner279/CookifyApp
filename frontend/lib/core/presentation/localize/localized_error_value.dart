import 'package:cookify/core/presentation/localize/localize.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_error_value.freezed.dart';

@freezed
abstract class LocalizedErrorValue<T> with _$LocalizedErrorValue<T> {
  const factory LocalizedErrorValue({
    required T value,
    Localize? localizeError,
  }) = _LocalizedErrorValue;
}
