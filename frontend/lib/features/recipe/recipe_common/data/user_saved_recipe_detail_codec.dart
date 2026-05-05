import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_step_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';

abstract final class UserSavedRecipeDetailCodec {
  static Map<String, dynamic> toJson(RecipeDetailEntity r) => {
    'id': r.id,
    'photoUrls': r.photoUrls,
    'name': r.name,
    'difficulty': r.difficulty.index,
    'categories': r.categories
        .map((c) => {'id': c.id, 'name': c.name})
        .toList(),
    'cookingTime': r.cookingTime,
    'cpfc': {
      'calories': r.cpfc.calories,
      'proteins': r.cpfc.proteins,
      'fats': r.cpfc.fats,
      'carbohydrates': r.cpfc.carbohydrates,
    },
    'description': r.description,
    'servingCount': r.servingCount,
    'ingredients': r.ingredients.map(_ingredientToJson).toList(),
    'steps': r.steps.map(_stepToJson).toList(),
  };

  static RecipeDetailEntity fromJson(Map<String, dynamic> json) {
    final diffIndex = (json['difficulty'] as num?)?.toInt() ?? 0;
    final safeDiff = diffIndex.clamp(0, RecipeDifficulty.values.length - 1);

    final cpfcMap = (json['cpfc'] as Map?)?.cast<String, dynamic>();
    final cpfc = CpfcEntity(
      calories: (cpfcMap?['calories'] as num?)?.toInt() ?? 0,
      proteins: (cpfcMap?['proteins'] as num?)?.toInt() ?? 0,
      fats: (cpfcMap?['fats'] as num?)?.toInt() ?? 0,
      carbohydrates: (cpfcMap?['carbohydrates'] as num?)?.toInt() ?? 0,
    );

    final categories = (json['categories'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) {
          final m = e.cast<String, dynamic>();
          return CategoryEntity(
            id: m['id']?.toString() ?? '',
            name: m['name']?.toString() ?? '',
          );
        })
        .toList();

    final ingredients = (json['ingredients'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => _ingredientFromJson(e.cast<String, dynamic>()))
        .toList();

    final steps = (json['steps'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => _stepFromJson(e.cast<String, dynamic>()))
        .toList();

    final photoUrls = (json['photoUrls'] as List<dynamic>? ?? const [])
        .map((e) => e.toString())
        .toList();

    return RecipeDetailEntity(
      id: json['id']?.toString() ?? '',
      creator: null,
      photoUrls: photoUrls,
      name: json['name']?.toString() ?? '',
      difficulty: RecipeDifficulty.values[safeDiff],
      categories: categories,
      cookingTime: (json['cookingTime'] as num?)?.toInt() ?? 0,
      cpfc: cpfc,
      description: json['description']?.toString() ?? '',
      servingCount: (json['servingCount'] as num?)?.toDouble() ?? 1,
      ingredients: ingredients,
      steps: steps,
    );
  }

  static Map<String, dynamic> _ingredientToJson(RecipeIngredientEntity i) => {
    'name': i.name,
    'amount': i.amount,
    'unit': i.unit,
    'cpfc': {
      'calories': i.cpfc.calories,
      'proteins': i.cpfc.proteins,
      'fats': i.cpfc.fats,
      'carbohydrates': i.cpfc.carbohydrates,
    },
  };

  static RecipeIngredientEntity _ingredientFromJson(Map<String, dynamic> m) {
    final cpfcMap = (m['cpfc'] as Map?)?.cast<String, dynamic>();
    return RecipeIngredientEntity(
      name: m['name']?.toString() ?? '',
      amount: (m['amount'] as num?)?.toDouble() ?? 0,
      unit: m['unit']?.toString() ?? '',
      cpfc: CpfcEntity(
        calories: (cpfcMap?['calories'] as num?)?.toInt() ?? 0,
        proteins: (cpfcMap?['proteins'] as num?)?.toInt() ?? 0,
        fats: (cpfcMap?['fats'] as num?)?.toInt() ?? 0,
        carbohydrates: (cpfcMap?['carbohydrates'] as num?)?.toInt() ?? 0,
      ),
    );
  }

  static Map<String, dynamic> _stepToJson(RecipeStepEntity s) => {
    'id': s.id,
    'name': s.name,
    'description': s.description,
    if (s.photoUrl != null && s.photoUrl!.isNotEmpty) 'photoUrl': s.photoUrl,
  };

  static RecipeStepEntity _stepFromJson(Map<String, dynamic> m) {
    return RecipeStepEntity(
      id: m['id']?.toString() ?? '0',
      name: m['name']?.toString() ?? '',
      description: m['description']?.toString() ?? '',
      photoUrl: m['photoUrl']?.toString(),
    );
  }
}
