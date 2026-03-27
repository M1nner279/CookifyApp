import 'package:cookify/config/theme/t.dart';
import 'package:cookify/feature/auth/presentation/page/login_page.dart';
import 'package:cookify/feature/auth/presentation/page/recover_password_page.dart';
import 'package:cookify/feature/auth/presentation/page/register_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

enum AuthTab { login, register, recover }

class AuthTabBar extends StatelessWidget {
  const AuthTabBar({super.key, required this.activeTab});

  final AuthTab activeTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Tab(
          onTap: activeTab == AuthTab.login
              ? null
              : () {
                  context.go(LoginPage.fullRoute());
                },
          isActive: activeTab == AuthTab.login,
          title: 'Вход',
        ),

        _Tab(
          onTap: activeTab == AuthTab.register
              ? null
              : () {
                  context.go(RegisterPage.fullRoute());
                },
          isActive: activeTab == AuthTab.register,
          title: 'Регистрация',
        ),

        _Tab(
          onTap: activeTab == AuthTab.recover
              ? null
              : () {
                  context.go(RecoverPasswordPage.fullRoute());
                },
          isActive: activeTab == AuthTab.recover,
          title: 'Восстановить',
        ),
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.onTap,
    required this.isActive,
    required this.title,
  });

  final VoidCallback? onTap;
  final bool isActive;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        padding: const .only(bottom: 16.0),
        decoration: BoxDecoration(
          border: isActive
              ? Border(
                  bottom: BorderSide(
                    color: T.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                )
              : null,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.35,
            height: 20.0 / 14.0,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
