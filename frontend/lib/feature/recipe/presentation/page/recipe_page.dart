import 'package:cookify/common/presentation/widget/cookify_app_bar.dart';
import 'package:cookify/common/presentation/widget/cookify_error_content.dart';
import 'package:cookify/common/presentation/widget/cookify_loading_content.dart';
import 'package:cookify/feature/recipe/presentation/bloc/recipe_cubit.dart';
import 'package:cookify/feature/recipe/presentation/bloc/recipe_state.dart';
import 'package:cookify/feature/recipe/presentation/widget/recipe_loaded_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  static const String route = '/recipes/:id';

  static String routeWithId(String id) => route.replaceFirst(':id', id.toString());

  static String fullRoute({required String id}) => routeWithId(id);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CookifyAppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        action: IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
      ),

      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          if (state is RecipeInitial) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<RecipeCubit>().getRecipe();
            });

            return const SizedBox.shrink();
          } else if (state is RecipeLoading) {
            return const CookifyLoadingContent();
          } else if (state is RecipeLoaded) {
            return RecipeLoadedContent(recipe: state.recipe);
          } else if (state is RecipeError) {
            return const CookifyErrorContent();
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
