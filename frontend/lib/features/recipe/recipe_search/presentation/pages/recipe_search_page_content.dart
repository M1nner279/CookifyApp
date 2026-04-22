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
                  return RecipeFeedRecipeList(
                    recipes: state.recipes,
                    isLoading: state.isLoading,
                    controller: controller,
                  );
                case RecipeSearchError():
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
