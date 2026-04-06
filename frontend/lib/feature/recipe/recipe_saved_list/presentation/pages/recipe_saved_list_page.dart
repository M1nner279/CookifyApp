import 'package:cookify/feature/recipe/recipe_saved_list/presentation/bloc/recipe_saved_list_cubit.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/presentation/pages/recipe_saved_list_page_content.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/presentation/widgets/recipe_saved_list_app_bar.dart';
import 'package:cookify/shared/presentation/widget/cookify_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RecipeSavedListPage extends StatelessWidget {
  const RecipeSavedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeSavedListAppBar(),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: CookifyNavigationBar.barHeight + 10.0,
            ),
            child: BlocProvider<RecipeSavedListCubit>.value(
              value: GetIt.instance(),
              child: RecipeSavedListPageContent(),
            ),
          ),

          const Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: CookifyNavigationBar(currentIndex: ActiveItem.favorite),
          ),
        ],
      ),

      backgroundColor: Color(0xFF1A0F0A),
    );
  }
}
