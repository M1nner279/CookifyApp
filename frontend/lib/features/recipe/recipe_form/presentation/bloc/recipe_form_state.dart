import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_step_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'recipe_form_state.freezed.dart';

@freezed
abstract class RecipeFormState with _$RecipeFormState {
  const factory RecipeFormState({
    required List<XFile> photos,
    required String name,
    required String description,
    required CpfcEntity cpfc,
    required RecipeDifficulty difficulty,
    required int cookingTime,
    required List<CategoryEntity> categories,
    required List<CategoryEntity> searchedCategories,
    required List<RecipeIngredientEntity> ingredients,
    required List<IngredientEntity> searchedIngredients,
    required bool isPublishing,
    required List<RecipeStepEntity> steps,
  }) = _RecipeFormState;

  factory RecipeFormState.initial() => const RecipeFormState(
    photos: [],
    name: '',
    description: '',
    cpfc: CpfcEntity(carbohydrates: 0, proteins: 0, fats: 0, calories: 0),
    difficulty: RecipeDifficulty.easy,
    cookingTime: 45,
    categories: [],
    searchedCategories: [],
    ingredients: [],
    searchedIngredients: [],
    isPublishing: false,
    steps: [],
  );
}
