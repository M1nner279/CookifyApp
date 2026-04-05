import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnimatedGoRoute extends GoRoute {
  AnimatedGoRoute({
    required super.path,
    required super.name,
    required Widget Function(BuildContext context, GoRouterState state) builder,
  }) : super(
         pageBuilder: (context, state) {
           return CustomTransitionPage(
             key: state.pageKey,
             child: builder(context, state),
             transitionsBuilder:
                 (context, animation, secondaryAnimation, child) {
                   const begin = Offset(-1.0, 0.0);
                   const end = Offset.zero;
                   const curve = Curves.easeInOut;

                   var tween = Tween(
                     begin: begin,
                     end: end,
                   ).chain(CurveTween(curve: curve));
                   var offsetAnimation = animation.drive(tween);

                   return SlideTransition(
                     position: offsetAnimation,
                     child: child,
                   );
                 },
           );
         },
       );
}
