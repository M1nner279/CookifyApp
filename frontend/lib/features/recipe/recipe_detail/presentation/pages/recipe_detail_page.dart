import 'package:cookify/features/recipe/recipe_detail/di/recipe_detail_di.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/bloc/recipe_detail_cubit.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/pages/recipe_detail_page_args.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/pages/recipe_detail_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key, required this.args});

  final RecipeDetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecipeDetailCubit>(
      create: (_) => RecipeDetailDi.getIt(param1: args.id),
      child: const RecipeDetailPageContent(),
    );
  }
}
