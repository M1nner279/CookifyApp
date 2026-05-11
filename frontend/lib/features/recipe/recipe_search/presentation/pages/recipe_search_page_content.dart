import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/core/presentation/widgets/cookify_loading_content.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/widgets/recipe_feed_recipe_list.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_cubit.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecipeSearchPageContent extends StatefulWidget {
  const RecipeSearchPageContent({super.key});

  @override
  State<RecipeSearchPageContent> createState() =>
      _RecipeSearchPageContentState();
}

class _RecipeSearchPageContentState extends State<RecipeSearchPageContent> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: Icon(Icons.arrow_back, color: const Color(0xFFE5C9A8)),
          ),
          title: Text(
            MyLocale.of(context).searchTitle,
            style: const TextStyle(
              color: Color(0xFFE5C9A8),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.72,
              height: 28.0 / 18.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF1A0F0A),
          surfaceTintColor: Color(0xFF1A0F0A),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocConsumer<RecipeSearchCubit, RecipeSearchState>(
            builder: (context, state) {
              switch (state) {
                case RecipeSearchInitial():
                  SchedulerBinding.instance.addPostFrameCallback(
                    (_) => context.read<RecipeSearchCubit>().searchRecipeList(),
                  );

                  return const CookifyLoadingContent();
                case RecipeSearchLoading():
                  return const CookifyLoadingContent();
                case RecipeSearchLoaded():
                  if (state.recipes.isEmpty) {
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
                                  Icons.search,
                                  size: 48.0,
                                  color: Color(0xFFE5C9A8),
                                ),
                              ),

                              Text(
                                MyLocale.of(context).recipeSearchText,
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
                            context.pop();
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
                              MyLocale.of(context).searchButton,
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
                  return RecipeFeedRecipeList(
                    recipes: state.recipes,
                    isLoading: state.isLoading,
                    controller: controller,
                    onAtBottom: () {
                      context.read<RecipeSearchCubit>().searchRecipeList();
                    },
                  );
                case RecipeSearchError():
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
                          context.read<RecipeSearchCubit>().searchRecipeList();
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
