import 'package:cookify/core/presentation/widgets/cookify_navigation_bar.dart';
import 'package:cookify/features/recipe/recipe_feed/di/recipe_feed_di.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/bloc/recipe_feed_cubit.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/pages/recipe_feed_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeFeedPage extends StatelessWidget {
  const RecipeFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecipeFeedCubit>(
      create: (_) => RecipeFeedDi.getIt(),
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: const RecipeFeedPageContent(),),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CookifyNavigationBar(index: 0),
            ),
          ],
        ),
      ),
    );
  }
}
