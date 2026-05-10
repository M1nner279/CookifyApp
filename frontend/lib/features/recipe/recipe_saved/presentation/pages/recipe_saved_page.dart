import 'package:cookify/core/presentation/widgets/cookify_navigation_bar.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/saved_recipe_repository.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_saved/presentation/widgets/recipe_saved_wrap.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RecipeSavedPage extends StatefulWidget {
  const RecipeSavedPage({super.key});

  @override
  State<RecipeSavedPage> createState() => _RecipeSavedPageState();
}

class _RecipeSavedPageState extends State<RecipeSavedPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = GetIt.I<SavedRecipeRepository>();
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Моя кухня',
                style: const TextStyle(
                  color: Color(0xFFE5C9A8),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.72,
                  height: 28.0 / 18.0,
                ),
              ),
              centerTitle: true,
              backgroundColor: const Color(0xFF1A0F0A),
              surfaceTintColor: const Color(0xFF1A0F0A),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 80.0,
              ),
              child: ValueListenableBuilder<List<RecipePreviewEntity>>(
                valueListenable: repository.savedRecipesListenable,
                builder: (context, recipes, _) {
                  if (recipes.isEmpty) {
                    return const Center(
                      child: Text(
                        'Пока нет сохранённых рецептов',
                        style: TextStyle(color: Color(0xFFE5C9A8)),
                      ),
                    );
                  }

                  return RecipeSavedWrap(recipes: recipes);
                },
              ),
            ),
            backgroundColor: const Color(0xFF1A0F0A),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CookifyNavigationBar(index: 3),
          ),
        ],
      ),
    );
  }
}
