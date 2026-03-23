import 'package:freezed_annotation/freezed_annotation.dart';

part 'cpfc.freezed.dart';

@freezed
abstract class Cpfc with _$Cpfc {
  const factory Cpfc({
    required int carbohydrates,
    required int proteins,
    required int fats,
    required int calories,
  }) = _Cpfc;
}
