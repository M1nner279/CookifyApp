import 'package:cookify/config/constant/app_constant.dart';
import 'package:cookify/config/l10n/s.dart';
import 'package:cookify/config/theme/t.dart';
import 'package:flutter/material.dart';

class AuthTop extends StatelessWidget {
  const AuthTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      children: [
        Text(
          appName,
          style: TextStyle(
            color: T.of(context).colorScheme.secondary,
            fontSize: 48.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -2.4,
            height: 48.0 / 48.0,
          ),
        ),

        Text(
          S.of(context).authSlogan,
          style: TextStyle(
            color: T.of(context).colorScheme.secondary,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.35,
            height: 20.0 / 14.0,
          ),
        ),
      ],
    );
  }
}
