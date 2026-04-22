import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/controllers/ingredient_controller.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/widgets/ingredient_text_field.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_form_cubit.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/widgets/recipe_search_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeSearchIngredientSection extends StatefulWidget {
  const RecipeSearchIngredientSection({
    super.key,
    required this.controllers,
    required this.ingredients,
  });

  final List<IngredientController> controllers;
  final List<IngredientEntity> ingredients;

  @override
  State<RecipeSearchIngredientSection> createState() =>
      _RecipeSearchIngredientSectionState();
}

class _RecipeSearchIngredientSectionState
    extends State<RecipeSearchIngredientSection> {
  @override
  Widget build(BuildContext context) {
    return RecipeSearchSectionCard(
      title: 'Ингредиенты',
      child: Column(
        spacing: 8.0,
        children: [
          ...List.generate(
            widget.controllers.length,
            (i) => IngredientTextField(
              key: ObjectKey(widget.controllers[i]),
              controller: widget.controllers[i],
              ingredients: widget.ingredients,
              onChanged: (name) {
                context.read<RecipeSearchFormCubit>().searchIngredientList(name);
              },
              onDelete: () => setState(() {
                widget.controllers.removeAt(i);
              }),
            ),
          ),

          GestureDetector(
            onTap: () => setState(() {
              widget.controllers.add(IngredientController());
            }),
            child: Row(
              children: [
                Icon(Icons.add, color: const Color(0xFFE5C9A8), size: 24.0),

                const Text(
                  'Добавить ингредиент',
                  style: TextStyle(color: Color(0xFFE5C9A8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
