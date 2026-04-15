import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_bar.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_bottom.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_top.dart';
import 'package:cookify/features/auth/sign_in/presentation/pages/sign_in_page.dart';
import 'package:cookify/features/auth/sign_up/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

enum AuthPageContentType { signIn, signUp, restore }

class AuthPageContent extends StatefulWidget {
  const AuthPageContent({super.key});

  @override
  State<AuthPageContent> createState() => _AuthPageContentState();
}

class _AuthPageContentState extends State<AuthPageContent> {
  var type = AuthPageContentType.signIn;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            border: Border.all(color: const Color(0x1AE5C9A8)),
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
                                                  ? const Offset(-1.0, 0.0)
                                                  : const Offset(1.0, 0.0),
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
                                child: _buildAuthContent(),
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
      ),
    );
  }

  Widget _buildAuthContent() {
    return switch (type) {
      AuthPageContentType.signIn => const SignInPage(),
      AuthPageContentType.signUp => const SignUpPage(),
      AuthPageContentType.restore => Placeholder(),//const RestorePage(),
    };
  }
}
