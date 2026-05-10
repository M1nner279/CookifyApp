import 'package:cookify/features/recipe/recipe_form/di/recipe_form_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/bloc/recipe_form_cubit.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/pages/recipe_form_page_content.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/pages/recipe_form_page_args.dart';

class RecipeFormPage extends StatelessWidget {
  const RecipeFormPage({super.key, required this.args});

  final RecipeFormPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecipeFormCubit>(
      create: (_) => RecipeFormDi.getIt(),
      child: RecipeFormPageContent(draftId: args.draftId),
    );
  }
}
