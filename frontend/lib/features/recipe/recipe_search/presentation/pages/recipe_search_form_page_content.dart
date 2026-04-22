import 'package:cookify/core/presentation/widgets/cookify_text_field.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/controllers/category_controller.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/controllers/ingredient_controller.dart';
import 'package:cookify/features/recipe/recipe_search/domain/payloads/search_recipe_list_payload.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_form_cubit.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_form_state.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_page_args.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/widgets/recipe_search_category_section.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/widgets/recipe_search_general_section.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/widgets/recipe_search_ingredient_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecipeSearchFormPageContent extends StatefulWidget {
  const RecipeSearchFormPageContent({super.key});

  @override
  State<RecipeSearchFormPageContent> createState() =>
      _RecipeSearchFormPageContentState();
}

class _RecipeSearchFormPageContentState
    extends State<RecipeSearchFormPageContent> {
  final recipeController = TextEditingController();

  final difficulties = <RecipeDifficulty>[];
  final maxCookingTimeController = TextEditingController();
  final minCarbohydratesController = TextEditingController();
  final maxCarbohydratesController = TextEditingController();
  final minProteinsController = TextEditingController();
  final maxProteinsController = TextEditingController();
  final minFatsController = TextEditingController();
  final maxFatsController = TextEditingController();
  final minCaloriesController = TextEditingController();
  final maxCaloriesController = TextEditingController();

  final categoryControllers = <CategoryController>[];

  final ingredientControllers = <IngredientController>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Поиск рецептов',
            style: const TextStyle(
              color: Color(0xFFE5C9A8),
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.0,
              height: 30.0 / 30.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF1A0F0A),
          surfaceTintColor: Color(0xFF1A0F0A),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: BlocConsumer<RecipeSearchFormCubit, RecipeSearchFormState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: CookifyTextField(
                      controller: recipeController,
                      onChanged: (_) {},
                      hint: 'Название рецепта',
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

                  SliverToBoxAdapter(
                    child: RecipeSearchGeneralSection(
                      difficulties: difficulties,
                      maxCookingTimeController: maxCookingTimeController,
                      minCarbohydratesController: minCarbohydratesController,
                      maxCarbohydratesController: maxCarbohydratesController,
                      minProteinsController: minProteinsController,
                      maxProteinsController: maxProteinsController,
                      minFatsController: minFatsController,
                      maxFatsController: maxFatsController,
                      minCaloriesController: minCaloriesController,
                      maxCaloriesController: maxCaloriesController,
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

                  SliverToBoxAdapter(
                    child: RecipeSearchCategorySection(
                      controllers: categoryControllers,
                      categories: state.categories,
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

                  SliverToBoxAdapter(
                    child: RecipeSearchIngredientSection(
                      controllers: ingredientControllers,
                      ingredients: state.ingredients,
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          '/search',
                          extra: RecipeSearchPageArgs(
                            payload: SearchRecipeListPayload(
                              name: recipeController.text,
                              difficulties: difficulties,
                              categories: categoryControllers
                                  .map((c) => c.category)
                                  .whereType<CategoryEntity>()
                                  .toList(),
                              ingredients: ingredientControllers
                                  .map((i) => i.ingredient)
                                  .whereType<IngredientEntity>()
                                  .toList(),
                              maxCookingTime:
                                  maxCookingTimeController.text.isEmpty
                                  ? null
                                  : int.parse(maxCookingTimeController.text),
                              minCarbohydrates:
                                  minCarbohydratesController.text.isEmpty
                                  ? null
                                  : int.parse(minCarbohydratesController.text),
                              maxCarbohydrates:
                                  maxCarbohydratesController.text.isEmpty
                                  ? null
                                  : int.parse(maxCarbohydratesController.text),
                              minProteins: minProteinsController.text.isEmpty
                                  ? null
                                  : int.parse(minProteinsController.text),
                              maxProteins: maxProteinsController.text.isEmpty
                                  ? null
                                  : int.parse(maxProteinsController.text),
                              minFats: minFatsController.text.isEmpty
                                  ? null
                                  : int.parse(minFatsController.text),
                              maxFats: maxFatsController.text.isEmpty
                                  ? null
                                  : int.parse(maxFatsController.text),
                              minCalories: minCaloriesController.text.isEmpty
                                  ? null
                                  : int.parse(minCaloriesController.text),
                              maxCalories: maxCaloriesController.text.isEmpty
                                  ? null
                                  : int.parse(maxCaloriesController.text),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5C9A8),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        width: double.infinity,
                        height: 64.0,
                        child: Text(
                          'Поиск',
                          style: const TextStyle(
                            color: Color(0xFF1A0F0A),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.4,
                            height: 24.0 / 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 32.0)),
                ],
              );
            },
            listener: (context, state) {},
          ),
        ),
        backgroundColor: Color(0xFF1A0F0A),
      ),
    );
  }
}
