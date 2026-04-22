import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class CategoryController {
  CategoryController();

  final _controller = TextEditingController();
  CategoryEntity? _category;

  TextEditingController get controller => _controller;
  CategoryEntity? get category => _category;

  void selectCategory(CategoryEntity category) =>
      _controller.text = category.name;

  void clearCategory() {
    _controller.clear();
    _category = null;
  }
}
