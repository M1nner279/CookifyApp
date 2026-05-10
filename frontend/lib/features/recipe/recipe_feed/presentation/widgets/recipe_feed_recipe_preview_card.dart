import 'package:cookify/features/recipe/recipe_common/domain/repositories/saved_recipe_repository.dart';
import 'package:cookify/core/presentation/widgets/cookify_cached_network_image.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/pages/recipe_detail_page_args.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/extensions/styled_recipe_difficulty.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class RecipeFeedRecipePreviewCard extends StatelessWidget {
  const RecipeFeedRecipePreviewCard({super.key, required this.recipe});

  final RecipePreviewEntity recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/recipes/${recipe.id}',
          extra: RecipeDetailPageArgs(id: recipe.id),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2C1C16),
          border: Border.all(color: const Color(0x1AE5C9A8)),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxWidth,
                    child: CookifyCachedNetworkImage(recipe.photoUrl),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe.name,
                          style: const TextStyle(
                            color: Color(0xFFE5C9A8),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                            height: 28.0 / 20.0,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8.0),

                      ValueListenableBuilder<List<RecipePreviewEntity>>(
                        valueListenable: GetIt.I<SavedRecipeRepository>()
                            .savedRecipesListenable,
                        builder: (context, _, _) {
                          final isSaved = GetIt.I<SavedRecipeRepository>()
                              .isSaved(recipe.id);
                          return IconButton(
                            iconSize: 24.0,
                            onPressed: () {
                              GetIt.I<SavedRecipeRepository>().toggleRecipe(
                                recipe,
                              );
                            },
                            icon: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border,
                              color: const Color(0xFFE5C9A8),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 4.0),

                  Row(
                    spacing: 12.0,
                    children: [
                      _Info(
                        iconData: Icons.access_time,
                        text: '${recipe.cookingTime} мин',
                      ),

                      _Info(
                        iconData: Icons.restaurant,
                        text: '${recipe.servingCount} порций',
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),

                  Row(
                    spacing: 8.0,
                    children: [
                      _Difficulty(difficulty: recipe.difficulty),

                      Expanded(
                        child: SizedBox(
                          height: 23.0,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) =>
                                _Category(category: recipe.categories[index]),
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 6.0),
                            itemCount: recipe.categories.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.iconData, required this.text});

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, size: 16.0, color: const Color(0xFFE5C9A8)),

        const SizedBox(width: 4.0),

        Text(
          text,
          style: const TextStyle(
            color: Color(0xFFE5C9A8),
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.0,
            height: 16.0 / 12.0,
          ),
        ),
      ],
    );
  }
}

class _Difficulty extends StatelessWidget {
  const _Difficulty({required this.difficulty});

  final RecipeDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: difficulty.color(),
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Text(
        difficulty.text(context),
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          height: 15.0 / 10.0,
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const .symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Text(
        category.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFFE5C9A8),
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          height: 15.0 / 10.0,
        ),
      ),
    );
  }
}
