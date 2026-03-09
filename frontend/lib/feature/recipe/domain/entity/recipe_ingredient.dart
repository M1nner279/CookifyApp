import 'package:cookify/feature/recipe/config/enum/ingredient_unit.dart';
import 'package:cookify/feature/recipe/domain/entity/ingredient.dart';

class RecipeIngredient extends Ingredient {
  const RecipeIngredient({
    required super.id,
    required super.name,
    required super.cpfc,
    required this.comment,
    required this.quantity,
    required this.unit,
  });

  final String? comment;
  final String quantity;
  final IngredientUnit unit;

  @override
  List<Object?> get props => [...super.props, comment, quantity, unit];
}
