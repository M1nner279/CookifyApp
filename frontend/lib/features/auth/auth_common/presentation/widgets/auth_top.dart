import 'package:cookify/core/l10n/my_locale.dart';
import 'package:flutter/material.dart';

class AuthTop extends StatelessWidget {
  const AuthTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      children: [
        const Text(
          'Cookify',
          style: TextStyle(
            color: Color(0xFFE5C9A8),
            fontSize: 48.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -2.4,
            height: 48.0 / 48.0,
          ),
        ),

        Text(
          MyLocale.of(context).authTopSubtitle,
          style: const TextStyle(
            color: Color(0xFFE5C9A8),
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.35,
            height: 20.0 / 14.0,
          ),
        ),
      ],
    );
  }
}
