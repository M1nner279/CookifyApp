import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/core/presentation/widgets/cookify_navigation_bar.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/saved_recipe_repository.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_saved/presentation/widgets/recipe_saved_wrap.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
              title: Text(
                MyLocale.of(context).recipeSavedTitle,
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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: 32,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF2C1C16),
                            border: Border.all(
                              color: Color(
                                0xFFE5C9A8,
                              ).withAlpha((0.1 * 255).toInt()),
                            ),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                          child: Column(
                            spacing: 16,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: Color(
                                    0xFFE5C9A8,
                                  ).withAlpha((0.05 * 255).toInt()),
                                  border: Border.all(
                                    color: Color(
                                      0xFFE5C9A8,
                                    ).withAlpha((0.1 * 255).toInt()),
                                  ),
                                  borderRadius: BorderRadius.circular(48.0),
                                ),
                                child: Icon(
                                  Icons.bookmark_border,
                                  size: 48.0,
                                  color: Color(0xFFE5C9A8),
                                ),
                              ),

                              Text(
                                MyLocale.of(context).recipeSavedEmptyMessage,
                                style: TextStyle(
                                  color: Color(0xFFE5C9A8),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.0,
                                  height: 20.0 / 16.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            context.go('/');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 26.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFE5C9A8),
                              borderRadius: BorderRadius.circular(48.0),
                            ),
                            child: Text(
                              MyLocale.of(context).recipeSavedFind,
                              style: TextStyle(
                                color: Color(0xFF2C1C16),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.0,
                                height: 20.0 / 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
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
