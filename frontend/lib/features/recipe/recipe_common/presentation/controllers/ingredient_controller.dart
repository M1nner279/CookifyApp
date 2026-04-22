import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:flutter/material.dart';

class IngredientController {
  IngredientController();

  final _controller = TextEditingController();
  IngredientEntity? _ingredient;

  TextEditingController get controller => _controller;
  IngredientEntity? get ingredient => _ingredient;

  void selectIngredient(IngredientEntity category) =>
      _controller.text = category.name;

  void clearIngredient() {
    _controller.clear();
    _ingredient = null;
  }
}
