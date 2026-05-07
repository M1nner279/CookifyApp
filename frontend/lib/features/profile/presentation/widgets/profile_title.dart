import 'package:cookify/core/l10n/my_locale.dart';
import 'package:flutter/material.dart';

class ProfileTitle extends StatelessWidget {
  const ProfileTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60.0,
      child: Text(
        MyLocale.of(context).profileTitle,
        style: const TextStyle(
          color: Color(0xFFE5C9A8),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.72,
          height: 28.0 / 18.0,
        ),
      ),
    );
  }
}
