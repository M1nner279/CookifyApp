import 'package:cookify/core/presentation/widgets/cookify_loading_content.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/bloc/recipe_feed_cubit.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/bloc/recipe_feed_state.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/widgets/recipe_feed_recipe_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeFeedPageContent extends StatefulWidget {
  const RecipeFeedPageContent({super.key});

  @override
  State<RecipeFeedPageContent> createState() => _RecipeFeedPageContentState();
}

class _RecipeFeedPageContentState extends State<RecipeFeedPageContent> {
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
          title: Text(
            'Cookify',
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
          child: BlocConsumer<RecipeFeedCubit, RecipeFeedState>(
            builder: (context, state) {
              switch (state) {
                case RecipeFeedInitial():
                  SchedulerBinding.instance.addPostFrameCallback(
                    (_) => context.read<RecipeFeedCubit>().getRecipeList(),
                  );

                  return const CookifyLoadingContent();
                case RecipeFeedLoading():
                  return const CookifyLoadingContent();
                case RecipeFeedLoaded():
                  return RecipeFeedRecipeList(
                    recipes: state.recipes,
                    isLoading: state.isLoading,
                    controller: controller,
                    onAtBottom: () {
                      context.read<RecipeFeedCubit>().getRecipeList();
                    },
                  );
                case RecipeFeedError():
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
