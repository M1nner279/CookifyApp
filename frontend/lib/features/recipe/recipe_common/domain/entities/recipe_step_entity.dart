import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_step_entity.freezed.dart';

@freezed
abstract class RecipeStepEntity with _$RecipeStepEntity {
  const factory RecipeStepEntity({
    required String id,
    required String name,
    String? photoUrl,
    required String description,
  }) = _RecipeStepEntity;
}
