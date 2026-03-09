import 'package:cookify/feature/recipe/presentation/bloc/recipe_cubit.dart';
import 'package:cookify/feature/recipe/presentation/page/recipe_page.dart';
import 'package:cookify/service/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RecipePage.route,
      builder: (context, state) {
        final id = state.pathParameters['id'];

        return BlocProvider<RecipeCubit>.value(
          value: DI.getIt(param1: id),
          child: const RecipePage(),
        );
      },
    ),
  ],
  initialLocation: RecipePage.fullRoute(id: '0'),
);
