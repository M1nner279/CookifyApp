import 'package:cookify/core/presentation/widgets/cookify_loading_content.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/bloc/recipe_feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CookifyPaginationListView<T extends Widget> extends StatelessWidget {
  const CookifyPaginationListView({
    super.key,
    required this.items,
    required this.isLoading,
    required this.onAtBottom,
    required this.controller,
  });

  final List<T> items;
  final bool isLoading;
  final Function onAtBottom;
  final ScrollController controller;

  bool _onScrollNotification(ScrollNotification scroll) {
    const threshold = 100.0;
    final atBottom =
        scroll.metrics.pixels >= scroll.metrics.maxScrollExtent - threshold;

    if (atBottom) {
      onAtBottom();
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<RecipeFeedCubit>().getRecipeList();
          },
          backgroundColor: Color(0xFF1A0F0A),
          color: Color(0xFFE5C9A8),
          child: ListView.separated(
            controller: controller,
            itemBuilder: (_, index) => index != items.length
                ? items[index]
                : const CookifyLoadingContent(),
            separatorBuilder: (_, _) => const SizedBox(height: 24.0),
            itemCount: isLoading ? items.length + 1 : items.length,
          ),
        ),
      ),
    );
  }
}
