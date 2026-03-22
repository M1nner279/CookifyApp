import 'package:cookify/common/presentation/widget/cookify_app_bar.dart';
import 'package:cookify/common/presentation/widget/cookify_error_content.dart';
import 'package:cookify/common/presentation/widget/cookify_loading_content.dart';
import 'package:cookify/feature/home/presentation/bloc/home_cubit.dart';
import 'package:cookify/feature/home/presentation/bloc/home_state.dart';
import 'package:cookify/feature/home/presentation/widget/home_loaded_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = '/';

  static String fullRoute() => route;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CookifyAppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.update))],
      ),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<HomeCubit>().getRecipeList();
            });

            return const SizedBox.shrink();
          } else if (state is HomeLoading) {
            return const CookifyLoadingContent();
          } else if (state is HomeLoaded) {
            return HomeLoadedContent(recipes: state.recipes);
          } else if (state is HomeError) {
            return const CookifyErrorContent();
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
