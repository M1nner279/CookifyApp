import 'package:cookify/feature/recipe/recipe_common/domain/entities/category.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/presentation/bloc/recipe_saved_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeFilter extends StatelessWidget {
  const RecipeFilter({
    super.key,
    required this.categories,
    required this.selectedCategories,
  });

  final List<CategoryEntity> categories;
  final List<CategoryEntity> selectedCategories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => index == 0
            ? _Category(
                onTap: () {
                  context.read<RecipeSavedListCubit>().toggleAllCategory();
                },
                isActive: selectedCategories.length == categories.length,
                category: 'All Recipes',
              )
            : _Category(
                onTap: () {
                  context
                      .read<RecipeSavedListCubit>()
                      .toggleCategory(categories[index - 1]);
                },
                isActive:
                    selectedCategories.length != categories.length &&
                    selectedCategories.contains(categories[index - 1]),
                category: categories[index - 1].name,
              ),
        separatorBuilder: (_, _) => const SizedBox(width: 8.0),
        itemCount: categories.length + 1,
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({
    required this.onTap,
    required this.isActive,
    required this.category,
  });

  final VoidCallback onTap;
  final bool isActive;
  final String category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE5C9A8) : const Color(0xFF2C1C16),
          borderRadius: BorderRadius.circular(9999.0),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isActive ? const Color(0xFF3E2D16) : const Color(0x9AFADCD2),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.0,
            height: 20.0 / 14.0,
          ),
        ),
      ),
    );
  }
}
