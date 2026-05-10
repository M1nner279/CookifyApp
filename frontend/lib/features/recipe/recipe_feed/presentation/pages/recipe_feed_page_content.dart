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
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.72,
              height: 28.0 / 18.0,
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 50,
                          horizontal: 32,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF2C1C16),
                          border: Border.all(
                            color: Color(
                              0xFFE5C9A8,
                            ).withAlpha((0.1 * 255).toInt()),
                          ),
                          borderRadius: BorderRadius.circular(48.0),
                        ),
                        child: Column(
                          spacing: 16,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                color: Color(
                                  0xFFE5C9A8,
                                ).withAlpha((0.05 * 255).toInt()),
                                border: Border.all(
                                  color: Color(
                                    0xFFE5C9A8,
                                  ).withAlpha((0.1 * 255).toInt()),
                                ),
                                borderRadius: BorderRadius.circular(48.0),
                              ),
                              child: Icon(
                                Icons.wifi_off,
                                size: 48.0,
                                color: Color(0xFFE5C9A8),
                              ),
                            ),

                            Text(
                              'Нет подключения к инернету. Подключитесь к сети и обновите страницу.',
                              style: TextStyle(
                                color: Color(0xFFE5C9A8),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.0,
                                height: 20.0 / 16.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          context.read<RecipeFeedCubit>().getRecipeList();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 26.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFE5C9A8),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                          child: Text(
                            'Обновить',
                            style: TextStyle(
                              color: Color(0xFF2C1C16),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.0,
                              height: 20.0 / 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
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
