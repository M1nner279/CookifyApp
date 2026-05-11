import 'package:cookify/core/presentation/widgets/cookify_navigation_bar.dart';
import 'package:cookify/features/recipe/recipe_search/di/recipe_search_di.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_form_cubit.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_form_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeSearchFormPage extends StatelessWidget {
  const RecipeSearchFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecipeSearchFormCubit>(
      create: (_) => RecipeSearchDi.getIt(),
      child: const RecipeSearchFormPageContent(),
    );
  }
}
