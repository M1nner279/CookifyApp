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
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.0,
              height: 30.0 / 30.0,
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
                  return const Text('Error');
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
