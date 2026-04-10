import 'package:cookify/config/constant/app_constant.dart';
import 'package:cookify/config/theme/t.dart';
import 'package:cookify/feature/recipe/recipe_detail/presentation/bloc/recipe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecipeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RecipeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(Icons.arrow_back, color: const Color(0xFFF5E6D3),),
      ),
      title: Text(
        appName,
        style: TextStyle(
          color: const Color(0xFFF5E6D3),
          fontSize: 24.0,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.0,
          height: 32.0 / 24.0,
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.favorite, size: 20.0, color: const Color(0xFFF5E6D3),)),

        IconButton(onPressed: () {
          context.read<RecipeCubit>().saveRecipe();
        }, icon: Icon(Icons.bookmark, size: 20.0, color: const Color(0xFFF5E6D3),)),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
