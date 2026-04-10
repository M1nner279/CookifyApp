import 'package:cookify/feature/auth/auth_common/presentation/pages/auth_page.dart';
import 'package:flutter/material.dart';

class AuthBar extends StatelessWidget {
  const AuthBar({super.key, required this.type, required this.onTypeChanged});

  final AuthPageContentType type;
  final void Function(AuthPageContentType) onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AuthBarItem(
          onTap: () {
            onTypeChanged(AuthPageContentType.signIn);
          },
          isSelected: type == AuthPageContentType.signIn,
          title: 'Вход',
        ),
        AuthBarItem(
          onTap: () {
            onTypeChanged(AuthPageContentType.signUp);
          },
          isSelected: type == AuthPageContentType.signUp,
          title: 'Регистрация',
        ),
        AuthBarItem(
          onTap: () {
            onTypeChanged(AuthPageContentType.restore);
          },
          isSelected: type == AuthPageContentType.restore,
          title: 'Восстановление',
        ),
      ],
    );
  }
}

class AuthBarItem extends StatelessWidget {
  const AuthBarItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.title,
  });

  final VoidCallback onTap;
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFFE5C9A8) : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE5C9A8),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.35,
            height: 20.0 / 14.0,
          ),
        ),
      ),
    );
  }
}
