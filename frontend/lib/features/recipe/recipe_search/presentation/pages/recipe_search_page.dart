import 'package:cookify/features/recipe/recipe_search/di/recipe_search_di.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_cubit.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_page_args.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeSearchPage extends StatelessWidget {
  const RecipeSearchPage({super.key, required this.args});

  final RecipeSearchPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecipeSearchCubit>(
      create: (_) => RecipeSearchDi.getIt(param1: args.payload),
      child: const RecipeSearchPageContent(),
    );
  }
}
