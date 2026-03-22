import 'package:cookify/shared/domain/entity/ingredient.dart';

class RecipeIngredient extends Ingredient {
  const RecipeIngredient({
    super.id,
    required super.name,
    required super.cpfc,
    required this.quantity,
  });

  final String quantity;

  @override
  List<Object?> get props => [...super.props, quantity];
}
