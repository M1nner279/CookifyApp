import 'package:freezed_annotation/freezed_annotation.dart';

part 'cpfc_entity.freezed.dart';

@freezed
abstract class CpfcEntity with _$CpfcEntity {
  const factory CpfcEntity({
    required int carbohydrates,
    required int proteins,
    required int fats,
    required int calories,
  }) = _CpfcEntity;
}
