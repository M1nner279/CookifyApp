import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/controllers/category_controller.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/widgets/category_text_field.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_form_cubit.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/widgets/recipe_search_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeSearchCategorySection extends StatefulWidget {
  const RecipeSearchCategorySection({
    super.key,
    required this.controllers,
    required this.categories,
  });

  final List<CategoryController> controllers;
  final List<CategoryEntity> categories;

  @override
  State<RecipeSearchCategorySection> createState() =>
      _RecipeSearchCategorySectionState();
}

class _RecipeSearchCategorySectionState
    extends State<RecipeSearchCategorySection> {
  @override
  Widget build(BuildContext context) {
    return RecipeSearchSectionCard(
      title: MyLocale.of(context).searchCategoriesTitle,
      child: Column(
        spacing: 8.0,
        children: [
          ...List.generate(
            widget.controllers.length,
            (i) => CategoryTextField(
              key: ObjectKey(widget.controllers[i]),
              controller: widget.controllers[i],
              categories: widget.categories,
              onChanged: (name) {
                context.read<RecipeSearchFormCubit>().searchCategoryList(name);
              },
              onDelete: () => setState(() {
                widget.controllers.removeAt(i);
              }),
            ),
          ),

          GestureDetector(
            onTap: () => setState(() {
              widget.controllers.add(CategoryController());
            }),
            child: Row(
              children: [
                Icon(Icons.add, color: const Color(0xFFE5C9A8), size: 24.0),

                Text(
                  MyLocale.of(context).searchAddCategory,
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
