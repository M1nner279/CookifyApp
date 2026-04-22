import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_bar.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_bottom.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_top.dart';
import 'package:cookify/features/auth/restore/presentation/pages/restore_page.dart';
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
                                alignment: Alignment.topCenter,
                                duration: const Duration(milliseconds: 300),
                                child: AnimatedSwitcher(
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
                                  duration: const Duration(milliseconds: 300),
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
      AuthPageContentType.restore => const RestorePage(),
    };
  }
}
