import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_step.freezed.dart';

@freezed
abstract class RecipeStep with _$RecipeStep {
  const factory RecipeStep({
    String? id,
    required String name,
    String? imageUrl,
    required String description,
  }) = _RecipeStep;
}
