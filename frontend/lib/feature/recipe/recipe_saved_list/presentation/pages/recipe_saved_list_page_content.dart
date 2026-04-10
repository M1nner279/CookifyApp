import 'package:cookify/feature/recipe/recipe_saved_list/presentation/bloc/recipe_saved_list_cubit.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/presentation/bloc/recipe_saved_list_state.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/presentation/widgets/recipe_filter.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/presentation/widgets/saved_recipe_preview_card.dart';
import 'package:cookify/shared/presentation/widget/cookify_loading_content.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeSavedListPageContent extends StatelessWidget {
  const RecipeSavedListPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeSavedListCubit, RecipeSavedListState>(
      builder: (context, state) {
        switch (state) {
          case RecipeSavedListInitial():
            SchedulerBinding.instance.addPostFrameCallback((_) {
              context.read<RecipeSavedListCubit>().getSavedRecipes();
            });

            return const CookifyLoadingContent();

          case RecipeSavedListLoading():
            return const CookifyLoadingContent();

          case RecipeSavedListLoaded():
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 16.0,
                children: [
                  RecipeFilter(
                    categories: state.categories,
                    selectedCategories: state.selectedCategories,
                  ),

                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 16.0,
                          runSpacing: 12.0,
                          children: state.filteredRecipes
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: constraints.maxWidth / 2 - 16.0,
                                        ),
                                        child: SavedRecipePreviewCard(recipe: e),
                                      );
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );

          default:
            throw UnimplementedError();
        }
      },
    );
  }
}
