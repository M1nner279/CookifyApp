import 'package:cookify/feature/auth/auth_common/di/auth_di.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_bottom.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_bar.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_top.dart';
import 'package:cookify/feature/auth/restore/presentation/bloc/restore_cubit.dart';
import 'package:cookify/feature/auth/restore/presentation/pages/restore_page_content.dart';
import 'package:cookify/feature/auth/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:cookify/feature/auth/sign_in/presentation/pages/sign_in_page_content.dart';
import 'package:cookify/feature/auth/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:cookify/feature/auth/sign_up/presentation/pages/sign_up_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthPageContentType { signIn, signUp, restore }

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthPageContentType type = AuthPageContentType.signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 48.0,
                    children: [
                      const AuthTop(),

                      Container(
                        padding: const EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C1C16),
                          borderRadius: BorderRadius.circular(48.0),
                        ),
                        child: Column(
                          spacing: 24.0,
                          children: [
                            AuthBar(
                              type: type,
                              onTypeChanged: (value) {
                                setState(() => type = value);
                              },
                            ),

                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              alignment: Alignment.topCenter,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                layoutBuilder:
                                    (
                                      Widget? currentChild,
                                      List<Widget> previousChildren,
                                    ) {
                                      return Stack(
                                        alignment: Alignment.topCenter,
                                        children: <Widget>[?currentChild],
                                      );
                                    },
                                transitionBuilder:
                                    (
                                      Widget child,
                                      Animation<double> animation,
                                    ) {
                                      final isInAnimation =
                                          child.key == ValueKey(type);

                                      return SlideTransition(
                                        position:
                                            Tween<Offset>(
                                              begin: isInAnimation
                                                  ? const Offset(1.0, 0.0)
                                                  : const Offset(-1.0, 0.0),
                                              end: Offset.zero,
                                            ).animate(
                                              CurvedAnimation(
                                                parent: animation,
                                                curve: Curves.easeInOut,
                                              ),
                                            ),
                                        child: FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                      );
                                    },
                                child: _buildAuthContent(type),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const AuthBottom(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFF1E100A),
    );
  }

  Widget _buildAuthContent(AuthPageContentType type) {
    switch (type) {
      case AuthPageContentType.signIn:
        return BlocProvider<SignInCubit>(
          key: ValueKey(type),
          create: (context) => AuthDi.getIt(),
          child: const SignInPageContent(),
        );
      case AuthPageContentType.signUp:
        return BlocProvider<SignUpCubit>(
          key: ValueKey(type),
          create: (context) => AuthDi.getIt(),
          child: const SignUpPageContent(),
        );
      case AuthPageContentType.restore:
        return BlocProvider<RestoreCubit>(
          key: ValueKey(type),
          create: (context) => AuthDi.getIt(),
          child: const RestorePageContent(),
        );
    }
  }
}
