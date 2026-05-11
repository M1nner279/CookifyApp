import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/core/presentation/widgets/cookify_loading_content.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/saved_recipe_repository.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/bloc/recipe_detail_cubit.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/bloc/recipe_detail_state.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/widgets/recipe_detail_info_card.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/widgets/recipe_detail_ingredients_card.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/widgets/recipe_detail_photos_card.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/widgets/recipe_detail_steps_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RecipeDetailPageContent extends StatelessWidget {
  const RecipeDetailPageContent({super.key});

  RecipePreviewEntity _toPreview(RecipeDetailEntity detail) {
    return RecipePreviewEntity(
      id: detail.id,
      photoUrl: detail.photoUrls.isEmpty ? '' : detail.photoUrls.first,
      name: detail.name,
      cookingTime: detail.cookingTime,
      servingCount: detail.servingCount.round(),
      difficulty: detail.difficulty,
      categories: detail.categories.map((e) => e.name).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFE5C9A8)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Cookify',
            style: const TextStyle(
              color: Color(0xFFE5C9A8),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.72,
              height: 28.0 / 18.0,
            ),
          ),
          actions: [
            BlocBuilder<RecipeDetailCubit, RecipeDetailState>(
              builder: (context, state) {
                if (state is! RecipeDetailLoaded) {
                  return const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.bookmark_border, color: Color(0xFFE5C9A8)),
                  );
                }

                final savedRepository = GetIt.I<SavedRecipeRepository>();
                final preview = _toPreview(state.recipe);

                return ValueListenableBuilder<List<RecipePreviewEntity>>(
                  valueListenable: savedRepository.savedRecipesListenable,
                  builder: (context, _, _) {
                    final isSaved = savedRepository.isSaved(preview.id);
                    return IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: const Color(0xFFE5C9A8),
                      ),
                      onPressed: () {
                        savedRepository.toggleRecipe(preview);
                      },
                    );
                  },
                );
              },
            ),
          ],
          centerTitle: true,
          backgroundColor: Color(0xFF1A0F0A),
          surfaceTintColor: Color(0xFF1A0F0A),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocConsumer<RecipeDetailCubit, RecipeDetailState>(
            builder: (context, state) {
              switch (state) {
                case RecipeDetailInitial():
                  SchedulerBinding.instance.addPostFrameCallback(
                    (_) => context.read<RecipeDetailCubit>().getRecipeDetail(),
                  );

                  return const CookifyLoadingContent();
                case RecipeDetailLoading():
                  return const CookifyLoadingContent();
                case RecipeDetailLoaded():
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: RecipeDetailPhotosCard(
                          photoUrls: state.recipe.photoUrls,
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 24.0)),

                      SliverToBoxAdapter(
                        child: RecipeDetailInfoCard(recipe: state.recipe),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 24.0)),

                      SliverToBoxAdapter(
                        child: RecipeDetailIngredientsCard(
                          servingCount: state.recipe.servingCount,
                          ingredients: state.recipe.ingredients,
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 24.0)),

                      SliverToBoxAdapter(
                        child: RecipeDetailStepsCard(steps: state.recipe.steps),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                    ],
                  );
                case RecipeDetailError():
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
                                Icons.wifi_off,
                                size: 48.0,
                                color: Color(0xFFE5C9A8),
                              ),
                            ),

                            Text(
                              MyLocale.of(context).commonOfflineMessage,
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
                          context.read<RecipeDetailCubit>().getRecipeDetail();
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
                            MyLocale.of(context).commonRefresh,
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
            },
            listener: (context, state) {},
          ),
        ),
        backgroundColor: Color(0xFF1A0F0A),
      ),
    );
  }
}
