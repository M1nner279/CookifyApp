import 'package:cookify/feature/home/presentation/bloc/home_cubit.dart';
import 'package:cookify/feature/home/presentation/page/home_page.dart';
import 'package:cookify/feature/recipe/presentation/bloc/recipe_cubit.dart';
import 'package:cookify/feature/recipe/presentation/page/recipe_page.dart';
import 'package:cookify/service/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: HomePage.route,
      builder: (context, state) {
        return BlocProvider<HomeCubit>.value(
          value: DI.getIt(),
          child: const HomePage(),
        );
      },
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
    ),
  ],
  initialLocation: HomePage.route,
);
